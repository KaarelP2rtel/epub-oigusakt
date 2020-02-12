#!/usr/bin/env python3

from oigusakt import Oigusakt
from ebooklib import epub
from mako.template import Template
import argparse
import os
from multiprocessing import Pool
import pkg_resources

def findTemplateFilename(name):
    resource_path = '/'.join(('templates', name))
    return pkg_resources.resource_filename(__name__, resource_path)

def makeBook(filename,addDisclaimer = True,addToc = True):


    path=os.path.abspath(filename)
    target=f"{os.path.splitext(path)[0]}.epub"

    print(f'Converting {path}')

    with open(filename) as xml:
        oigusakt = Oigusakt(xml)
    LANG='ee'

    book = epub.EpubBook()
    book.set_language(LANG)
    book.spine = []

    book.set_title(oigusakt.aktinimi.nimi.pealkiri)
    book.add_author(oigusakt.metaandmed.valjaandja)



    if addDisclaimer:
        with open(findTemplateFilename('texts/disclaimer.txt'),'r') as text:
            disclaimer_text = text.read()

        with open(findTemplateFilename('texts/info.txt')) as text:
            info_text = text.read()

        book_disclaimer=epub.EpubHtml(
            title='Märkus',
            file_name='disclaimer.xhtml',
            lang=LANG,
            content=Template(filename=findTemplateFilename('disclaimer.mako'))
                .render(disclaimer=disclaimer_text,info=info_text)
        )
        book.add_item(book_disclaimer)
        book.spine.append(book_disclaimer)

    if addToc:
        table_of_contents=epub.EpubHtml(
            title='sisukord',
            file_name='sisukord.xhtml',
            lang=LANG,
            content=Template(filename=findTemplateFilename('toc.mako')).\
                render(peatykid=oigusakt.sisu.peatykid)
        )
        book.add_item(table_of_contents)
        book.spine.append(table_of_contents)



    book_cover=epub.EpubHtml(
        title=oigusakt.aktinimi.nimi.pealkiri,
        file_name='esileht.xhtml',
        lang=LANG,
        content=Template(filename=findTemplateFilename('esileht.mako')).\
            render(metaandmed=oigusakt.metaandmed, aktinimi=oigusakt.aktinimi)
    )
    book.add_item(book_cover)
    book.spine.append(book_cover)


    for peatykk in oigusakt.sisu.peatykid:
        book_chapter = epub.EpubHtml(
            title = peatykk.peatykkPealkiri,
            file_name = f'{peatykk.id}.xhtml',
            lang = LANG,
            content=Template(filename=findTemplateFilename('peatykk.mako')).render(peatykk=peatykk)
        )
        book.add_item(book_chapter)
        book.spine.append(book_chapter)

    epub.write_epub(target, book, {})
    print(f'Finished  {target}')
def main():
    parser = argparse.ArgumentParser(description='Process riigiteataja xml files into epub files')

    parser.add_argument('-t', '--threads',
                        metavar='N',
                        action='store',
                        default=1,
                        type=int,
                        help='how many threads to use while converting (default: 1)')

    parser.add_argument('--omit-disclaimer',
                        action='store_true',
                        help='Leave out the disclaimer page'
    )
    parser.add_argument('--omit-toc',
                        action='store_true',
                        help='Leave out the Table of contents'
    )
    parser.add_argument('files',
                        nargs='*',
                        metavar='FILE',
                        help='XML files to convert to books',)

    args = parser.parse_args()
    if args.files:
        for i in args.files:
            makeBook(filename=i,
                    addDisclaimer=not args.omit_disclaimer,
                    addToc=not args.omit_toc)
    else:
        parser.print_help()


if __name__ == "__main__":
   main()


