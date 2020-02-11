<h1>${peatykk.kuvatavNr}</h1>
<h2>${peatykk.peatykkPealkiri}</h2>

% if peatykk.paragrahvid:
    % for paragrahv in peatykk.paragrahvid:
        ${makeParagrahv(paragrahv)}
    % endfor

%elif peatykk.jaod:
    % for jagu in peatykk.jaod:
        ${makeJagu(jagu)}
    % endfor
% endif

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

<%def name="makeJagu(jagu)">
    <center><h3 id="${jagu.id}">
        ${jagu.kuvatavNr}
    </h3></center>
    <center>
        <h3>
            ${jagu.jaguPealkiri}
        </h3></center>
    % for paragrahv in jagu.paragrahvid:
        ${makeParagrahv(paragrahv)}
    % endfor
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