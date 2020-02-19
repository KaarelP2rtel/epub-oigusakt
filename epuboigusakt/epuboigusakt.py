#!/usr/bin/env python3

from oigusakt import Seadus, Maarus
from ebooklib import epub
from mako.template import Template
import argparse
import os
from multiprocessing import Pool
import pkg_resources
LANG='ee'

def findTemplateFilename(name):
    resource_path = '/'.join(('templates', name))
    return pkg_resources.resource_filename(__name__, resource_path)

def makeDisclaimer():
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
    return book_disclaimer

def makeBase(akt,addDisclaimer=True):
    book = epub.EpubBook()
    book.set_language(LANG)
    book.spine = []

    book.set_title(akt.aktinimi.nimi.pealkiri)
    book.add_author(akt.metaandmed.valjaandja)
    if addDisclaimer:
        disclaimer=makeDisclaimer()
        book.add_item(disclaimer)
        book.spine.append(disclaimer)
    
    return book

def makeCover(akt):
    cover=epub.EpubHtml(
        title=akt.aktinimi.nimi.pealkiri,
        file_name='esileht.xhtml',
        lang=LANG,
        content=Template(filename=findTemplateFilename('esileht.mako')).\
            render(
                metaandmed=akt.metaandmed, 
                aktinimi=akt.aktinimi, 
                preambul=akt.sisu.preambul
                )
    )
    return cover
def makePeatykk(peatykk, filenameprefix=''):
    page = epub.EpubHtml(
            title = peatykk.peatykkPealkiri,
            file_name = f'{filenameprefix}{peatykk.id}.xhtml',
            lang = LANG,
            content=Template(
                filename=findTemplateFilename('peatykk.mako')).render(
                    peatykk=peatykk,filenameprefix=filenameprefix
                    )
        )
    return page

       
def makeOsa(osa):
    page = epub.EpubHtml(
            title = osa.osaPealkiri,
            file_name = f'{osa.id}.xhtml',
            lang = LANG,
            content=Template(filename=findTemplateFilename('osa.mako')).render(osa=osa)
        )
    return page

def makePseudoPeatykk(osa):
    pseudoPeatykk = type('',(object,),{
        'id':f"{osa.id}_pseudopeatykk",
        'paragrahvid':osa.paragrahvid,
        'peatykkPealkiri':'',
        'kuvatavNr':'',
        'peatykkNr':'',
        'muutmismarge': None,
        'jaod': None
    })()
    return pseudoPeatykk

def makeChangesPage(muutmismarkmed):
    changesPage=epub.EpubHtml(
        title='Muutmismärkmed',
        file_name='muutmismarkmed.xhtml',
        lang=LANG,
        content=Template(filename=findTemplateFilename('muutmismarkmed.mako')).render(muutmismarkmed=muutmismarkmed)
    )
    return changesPage

def makeSeadus(seadus,args,addDisclaimer = True,addToc = True):

    book = makeBase(seadus,addDisclaimer=addDisclaimer)
    sisu=seadus.sisu

    if addToc:
        table_of_contents=epub.EpubHtml(
            title='sisukord',
            file_name='sisukord.xhtml',
            lang=LANG,
            content=Template(filename=findTemplateFilename('toc.mako')).\
                render(sisu=sisu,muutmismarkmed=seadus.muutmismarkmed is not None)

        )
        book.add_item(table_of_contents)
        book.spine.append(table_of_contents)

    cover=makeCover(seadus)
    book.add_item(cover)
    book.spine.append(cover)

    if seadus.muutmismarkmed:
        changes=makeChangesPage(seadus.muutmismarkmed)
        book.add_item(changes)
        book.spine.append(changes)

    

    if sisu.peatykid:
        for peatykk in sisu.peatykid:
            peatykk = makePeatykk(peatykk)
            book.add_item(peatykk)
            book.spine.append(peatykk)
          
    elif sisu.osad:
        for osa in sisu.osad:
            osaPage=makeOsa(osa)
            book.add_item(osaPage)
            book.spine.append(osaPage)
            if osa.peatykid:
                for peatykk in osa.peatykid:
                    pt = makePeatykk(peatykk,filenameprefix=osa.id)
                    book.add_item(pt)
                    book.spine.append(pt)

            elif osa.paragrahvid:
                pt = makePeatykk(makePseudoPeatykk(osa),filenameprefix=osa.id)
                book.add_item(pt)
                book.spine.append(pt)

    return book

def makeMaarus(maarus,args,addDisclaimer = True,addToc = True):

    book = makeBase(maarus,addDisclaimer=addDisclaimer)

    cover=makeCover(maarus)
    book.add_item(cover)
    book.spine.append(cover)
    if maarus.muutmismarkmed:
        changesPage=makeChangesPage(maarus.muutmismarkmed)
        book.add_item(changesPage)
        book.spine.append(changesPage)

    book_chapter = epub.EpubHtml(
        title = maarus.aktinimi.nimi.pealkiri,
        file_name = f'maarus.xhtml',
        lang = LANG,
        content=Template(filename=findTemplateFilename('maarus.mako')).render(maarus=maarus)
    )
    book.add_item(book_chapter)
    book.spine.append(book_chapter)
    return book



def makeBook(filename,addDisclaimer = True,addToc = True):
    path=os.path.abspath(filename)
    target=f"{os.path.splitext(path)[0]}.epub"

    print(f'Converting {path}')

    with open(filename) as xml:
        xmlstring = xml.read()

    if 'tyviseadus' in xmlstring:
        book = makeSeadus(Seadus(xmlstring),addDisclaimer,addToc)
    elif 'maarus' in xmlstring:
        book = makeMaarus(Maarus(xmlstring),addDisclaimer,addToc)
    else:
        print("Sellist akti ei oska ma töödelda :(")
        exit

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


