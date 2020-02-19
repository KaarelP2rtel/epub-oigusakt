
% for paragrahv in maarus.sisu.paragrahvid:
    ${makeParagrahv(paragrahv)}
% endfor
% for allkiri in maarus.allkirjad:
    <p>${makeAllkiri(allkiri)}<p>
%  endfor

<%def name="makeParagrahv(paragrahv)">
    <h4 id="${paragrahv.id}">
        ${paragrahv.kuvatavNr}
        ${paragrahv.paragrahvPealkiri}
    </h4>
    % if paragrahv.sisuTekst:
        ${paragrahv.sisuTekst.valmistekst}
    % endif
    % if paragrahv.muutmismarge:
        ${makeMuutmismarge(paragrahv.muutmismarge)}
    % endif
     % for loige in paragrahv.loiked:
        ${makeLoige(loige)}
    %endfor

</%def>


<%def name="makeLoige(loige)">
    <p>
        % if loige.kuvatavNr:
            ${loige.kuvatavNr}
        % endif
        % if loige.sisuTekst:
            ${loige.sisuTekst.valmistekst}<br/>
        %endif
        % if loige.muutmismarge:
            ${makeMuutmismarge(loige.muutmismarge)}
        % endif
    </p>

    % if loige.alampunktid:
        <ul style="list-style-type:none;">
            % for alampunkt in loige.alampunktid:
                ${makeAlampunkt(alampunkt)}
            % endfor
        </ul>
    % endif
     
</%def>

<%def name="makeAlampunkt(alampunkt)">
    <li>
        ${alampunkt.kuvatavNr}
        % if alampunkt.sisuTekst:
            ${alampunkt.sisuTekst.valmistekst}
        % endif
    </li>
     % if alampunkt.muutmismarge:
         <li>${makeMuutmismarge(alampunkt.muutmismarge)}</li>
    % endif
</%def>
<%def name="makeMuutmismarge(marge)">
    <font color="gray">
        ${marge.valmismarge}
    </font>
</%def>
<%def name="makeAllkiri(allkiri)">
    <div>
        ${allkiri.allkirjastaja.eesnimi} 
        ${allkiri.allkirjastaja.perekonnanimi}
    </div>
    <div>
        ${allkiri.allkirjastaja.ametinimetus}
    </div>
</%def>
