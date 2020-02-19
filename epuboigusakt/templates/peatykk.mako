<h1>${peatykk.kuvatavNr}</h1>
<h2>${peatykk.peatykkPealkiri}</h2>

% if peatykk.paragrahvid:
    % if peatykk.muutmismarge:
        ${makeMuutmismarge(peatykk.muutmismarge)}
    % endif
    % for paragrahv in peatykk.paragrahvid:
        ${makeParagrahv(paragrahv)}
    % endfor

% elif peatykk.jaod:
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
        % if paragrahv.muutmismarge:
            ${makeMuutmismarge(paragrahv.muutmismarge)}
        % endif
    % elif paragrahv.sisuTekst:
        <b id="${paragrahv.id}">${paragrahv.kuvatavNr}</b>
        ${paragrahv.sisuTekst.valmistekst}
        % if paragrahv.muutmismarge:
            ${makeMuutmismarge(paragrahv.muutmismarge)}
        % endif
    % else:
        <b id="${paragrahv.id}">
            ${paragrahv.kuvatavNr}
        </b>
        % if paragrahv.muutmismarge:
            ${makeMuutmismarge(paragrahv.muutmismarge)}
        % endif
    % endif
    % for loige in paragrahv.loiked:
        ${makeLoige(loige)}
    % endfor
    
</%def>

<%def name="makeJagu(jagu)">
    <center>
        <h3 id="${jagu.id}">
        ${jagu.kuvatavNr}<br/>
        ${jagu.jaguPealkiri if jagu.jaguPealkiri else ''}
        </h3>
        % if jagu.muutmismarge:
            ${makeMuutmismarge(jagu.muutmismarge)}
        % endif
    </center>
    % if jagu.paragrahvid:
        % for paragrahv in jagu.paragrahvid:
            ${makeParagrahv(paragrahv)}
        % endfor
    % elif jagu.jaotised:
        % for jaotis in jagu.jaotised:
            ${makeJaotis(jaotis)}
        % endfor
    % endif
</%def>

<%def name="makeJaotis(jaotis)">
    <center>
        <h3 id="${jaotis.id}">
            ${jaotis.kuvatavNr}<br/>
            ${jaotis.jaotisPealkiri}
        </h3>
        % if jaotis.muutmismarge:
                ${makeMuutmismarge(jaotis.muutmismarge)}
        % endif
    </center>
    % if jaotis.paragrahvid:
        % for paragrahv in jaotis.paragrahvid:
            ${makeParagrahv(paragrahv)}
        % endfor
    % elif jaotis.alljaotised:
        % for  alljaotis in jaotis.alljaotised:
            ${makeAlljaotis(alljaotis)}
        % endfor
    % endif
</%def>
<%def name="makeAlljaotis(alljaotis)">
    <center>
        <h3 id="${alljaotis.id}">
            ${alljaotis.kuvatavNr}<br/>
            ${alljaotis.alljaotisPealkiri}
        </h3>
        % if alljaotis.muutmismarge:
                ${makeMuutmismarge(alljaotis.muutmismarge)}
        % endif
    </center>
    % if alljaotis.paragrahvid:
        % for paragrahv in alljaotis.paragrahvid:
            ${makeParagrahv(paragrahv)}
        % endfor
    % endif
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
    % if alampunkt.sisuTekst:
    <li>
        ${alampunkt.kuvatavNr}
        ${alampunkt.sisuTekst.valmistekst}
    </li>
        % if alampunkt.muutmismarge:
            <li>
                ${makeMuutmismarge(alampunkt.muutmismarge)}
            </li>
        % endif
    % else:
    <li>
        ${alampunkt.kuvatavNr}
        % if alampunkt.muutmismarge:
                ${makeMuutmismarge(alampunkt.muutmismarge)}
        % endif
    </li>
    %endif

</%def>
<%def name="makeMuutmismarge(marge)">
    <font color="gray">
        ${marge.valmismarge}
    </font>
</%def>
