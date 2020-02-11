#!/usr/bin/env python3

from oigusakt import Oigusakt
from ebooklib import epub
from mako.template import Template

file="relvaseadus"
with open(f"{file}.xml") as xml:
    oigusakt = Oigusakt(xml)
LANG="ee"
book = epub.EpubBook()
book.set_language(LANG)
book.spine = []

book.set_title(oigusakt.aktinimi.nimi.pealkiri)
book.add_author(oigusakt.metaandmed.valjaandja)

with open('templates/texts/disclaimer.txt') as disclaimer:
    disclaimer_text=disclaimer.read()

with open('templates/texts/info.txt') as info:
    info_text=info.read()


book_disclaimer=epub.EpubHtml(
    title='Märkus',
    file_name='disklaimer.xhtml',
    lang=LANG,
    content=Template(filename='templates/disclaimer.mako').render(disclaimer=disclaimer_text,info=info_text)
)
book.add_item(book_disclaimer)
book.spine.append(book_disclaimer)

table_of_contents=epub.EpubHtml(
    title='sisukord',
    file_name='sisukord.xhtml',
    lang=LANG,
    content=Template(filename='templates/toc.mako').\
        render(peatykid=oigusakt.sisu.peatykid)
)
book.add_item(table_of_contents)
book.spine.append(table_of_contents)

book_cover=epub.EpubHtml(
    title=oigusakt.aktinimi.nimi.pealkiri,
    file_name='esileht.xhtml',
    lang=LANG,
    content=Template(filename='templates/esileht.mako').\
        render(metaandmed=oigusakt.metaandmed, aktinimi=oigusakt.aktinimi)
)
book.add_item(book_cover)
book.spine.append(book_cover)


for peatykk in oigusakt.sisu.peatykid:
    book_chapter = epub.EpubHtml(
        title = peatykk.peatykkPealkiri,
        file_name = f'{peatykk.id}.xhtml',
        lang = LANG,
        content=Template(filename='templates/peatykk.mako').render(peatykk=peatykk)
    )
    book.add_item(book_chapter)
    book.spine.append(book_chapter)

epub.write_epub(f'{file}.epub', book, {})
