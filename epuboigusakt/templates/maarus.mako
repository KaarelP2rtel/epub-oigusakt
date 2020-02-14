
% for paragrahv in maarus.sisu.paragrahvid:
    ${makeParagrahv(paragrahv)}
% endfor

<%def name="makeParagrahv(paragrahv)">
    % if paragrahv.paragrahvPealkiri:
        <h4 id="${paragrahv.id}">
            ${paragrahv.kuvatavNr}
            ${paragrahv.paragrahvPealkiri}
        </h4>
    % elif paragrahv.sisuTekst:
        <b>${paragrahv.kuvatavNr}</b>
        ${paragrahv.sisuTekst.tavatekst}
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
            ${loige.sisuTekst.tavatekst}
        %endif
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
            ${alampunkt.sisuTekst.tavatekst}
        % endif
    </li>
</%def>