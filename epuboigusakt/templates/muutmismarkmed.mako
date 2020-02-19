<table border="1">
<h3>Muudetud j&auml;rgmiste aktidega:</h3>
<tr>
    <th align="left" >Vastuv&otilde;tmine</th>
    <th align="left" style="width:40%;">Avaldamine</th>
    <th align="left" style="width:60%;">J&otilde;ustumine</th>
</tr>
% for marge in muutmismarkmed:
    % if marge.aktikuupaev:
    <tr>
        <td>
            ${marge.aktikuupaev}
        </td>
        <td>
            ${makeAvaldamismarge(marge.avaldamismarge)}
        </td>
        <td>
            ${marge.joustumine if marge.joustumine else ''}
            ${marge.valmistekst if marge.valmistekst else ''}
        </td>
        
    </tr>
    % else:
    <tr>
        <td>
            ${marge.valmistekst if marge.valmistekst else ''}
        </td>
        <td>
            ${makeAvaldamismarge(marge.avaldamismarge)}
        </td>
        <td>

        </td>
        
    </tr>
    % endif
    
% endfor
</table>
<%def name="makeAvaldamismarge(marge)">
    ${marge.RTosa}
    ## ${marge.RTaasta if marge.RTaasta else marge.avaldamineKuupaev},
    % if marge.RTaasta:
        ${marge.RTaasta}
    % elif marge.avaldamineKuupaev:
        ${marge.avaldamineKuupaev}
    % endif
    % if marge.RTnr:
        ${marge.RTnr} ,
    % endif
    ${marge.RTartikkel}
</%def>

## <avaldamismarge>
## 				<RTosa>RT I</RTosa>
## 				<RTaasta>2009</RTaasta>
## 				<RTnr>60</RTnr>
## 				<RTartikkel>395</RTartikkel>
## 				<aktViide>13240237</aktViide>