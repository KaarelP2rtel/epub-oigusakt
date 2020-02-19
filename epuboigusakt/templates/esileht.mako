<table>
    <tr>
        <td align="left">V&auml;ljaandja:</td>
        <td>${metaandmed.valjaandja}</td>
    </tr>
    <tr>
        <td align="left">Akti liik:</td>
        <td>${metaandmed.dokumentLiik}</td>
    </tr>
    <tr>
        <td align="left">Teksti liik:</td>
        <td>${metaandmed.tekstiliik}</td>
    </tr>
    <tr>
        <td align="left">Redaktsiooni j&otilde;ustumise kp:</td>
        <td>${metaandmed.kehtivus.kehtivuseAlgus}</td>
    </tr>

</table>

<center>
    <h1>${aktinimi.nimi.pealkiri}
  
    </h1>
    <div>Vastu v&otilde;etud ${metaandmed.vastuvoetud.aktikuupaev}</div>
    % if metaandmed.vastuvoetud.joustumine:
        <div>J&otilde;ustumine ${metaandmed.vastuvoetud.joustumine}</div>
    % endif
</center>
<br/>
<br/>
<br/>
% if preambul:
    <p>${preambul.valmistekst}</p>
% endif

<%def name="makeAvaldamismarge(marge)">
    ${marge.RTosa}
    ${marge.RTaasta if marge.RTaasta else marge.avaldamineKuupaev},
    % if marge.RTnr:
        ${marge.RTnr} ,
    % endif
    ${marge.RTartikkel}
</%def>
