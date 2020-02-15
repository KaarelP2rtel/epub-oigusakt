<h1>Sisukord</h1>
<ul style="list-style-type:none;">
    <a href="esileht.xhtml">
        <h3>Esileht<h3>
    </a>
    % if sisu.osad:
        % for osa in sisu.osad:
            ${makeOsa(osa)}            
        % endfor
    % elif sisu.peatykid:
        % for peatykk in sisu.peatykid:
            ${makePeatykk(peatykk)}
        % endfor
    % endif
</ul>



<%def name="makeOsa(osa)">
    <li>
        <a href="${osa.id}.xhtml">
            <h3>
                ${osa.kuvatavNr}:
                ${osa.osaPealkiri if osa.osaPealkiri else ''}
            </h3>
        </a>
    </li>

    <ul style="list-style-type:none;">
    %if osa.paragrahvid:
        % for paragrahv in osa.paragrahvid:
            ${makeParagrahv(paragrahv,f'{osa.id}_pseudopeatykk.xhtml')}
        % endfor
    % elif osa.peatykid:
        % for peatykk in osa.peatykid:
            ${makePeatykk(peatykk,filenameprefix=osa.id)}
        % endfor
    % endif
    </ul>
</%def>

<%def name="makePeatykk(peatykk,filenameprefix='')">
    <li>
        <a href="${filenameprefix}${peatykk.id}.xhtml">
            <h3>
                ${peatykk.kuvatavNr}:
                ${peatykk.peatykkPealkiri if peatykk.peatykkPealkiri else ''}
            </h3>
        </a>
    </li>

    <ul style="list-style-type:none;">
    %if peatykk.paragrahvid:
        % for paragrahv in peatykk.paragrahvid:
            ${makeParagrahv(paragrahv,f'{filenameprefix}{peatykk.id}.xhtml')}
        % endfor
    % elif peatykk.jaod:
        % for jagu in peatykk.jaod:
            ${makeJagu(jagu,f'{filenameprefix}{peatykk.id}.xhtml')}
        % endfor
    % endif
    </ul>
</%def>
<%def name="makeParagrahv(paragrahv,peatykkHref)">
    % if paragrahv.paragrahvPealkiri:
    <li>
        <a href="${peatykkHref}#${paragrahv.id}">
            <b>${paragrahv.kuvatavNr}</b>
            ${paragrahv.paragrahvPealkiri}
        </a>
    </li>
    % endif
</%def>
<%def name="makeJagu(jagu,peatykkHref)">
    <li>
        <a href="${peatykkHref}#${jagu.id}">
            <h4>
                ${jagu.kuvatavNr}:
                ${jagu.jaguPealkiri if jagu.jaguPealkiri else ''}
            </h4>
        </a>
    </li>

    % if jagu.jaotised:
        <ul style="list-style-type:none;">
            % for jaotis in jagu.jaotised:
                ${makeJaotis(jaotis,peatykkHref)}
            % endfor
        </ul>
    % elif jagu.paragrahvid:
        <ul style="list-style-type:none;">
            % for paragrahv in jagu.paragrahvid:
                ${makeParagrahv(paragrahv,peatykkHref)}
            % endfor
        </ul>
    % endif
</%def>

<%def name="makeJaotis(jaotis,peatykkHref)">
    <li>
        <a href="${peatykkHref}#${jaotis.id}">
            <h4>
                ${jaotis.kuvatavNr}:
                ${jaotis.jaotisPealkiri if jaotis.jaotisPealkiri else ''}
            </h4>
        </a>
    </li>

    % if jaotis.alljaotised:
        <ul style="list-style-type:none;">
            % for alljaotis in jaotis.alljaotised:
                ${makeAllJaotis(alljaotis,peatykkHref)}
            % endfor
        </ul>
    % elif jaotis.paragrahvid:
        <ul style="list-style-type:none;">
            % for paragrahv in jaotis.paragrahvid:
                ${makeParagrahv(paragrahv,peatykkHref)}
            % endfor
        </ul>
    % endif
</%def>

<%def name="makeAllJaotis(alljaotis,peatykkHref)">
    <li>
        <a href="${peatykkHref}#${alljaotis.id}">
            <h4>
                ${alljaotis.kuvatavNr}:
                ${alljaotis.alljaotisPealkiri if alljaotis.alljaotisPealkiri else ''}
            </h4>
        </a>
    </li>

    % if alljaotis.paragrahvid:
        <ul style="list-style-type:none;">
            % for paragrahv in alljaotis.paragrahvid:
                ${makeParagrahv(paragrahv,peatykkHref)}
            % endfor
        </ul>
    % endif
</%def>


