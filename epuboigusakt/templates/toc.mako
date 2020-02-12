<h1>Sisukord</h1>
<ul style="list-style-type:none;">
    <a href="esileht.xhtml">
        <h3>Esileht<h3>
    </a>
    %for peatykk in peatykid:
        <li>
            <a href="${peatykk.id}.xhtml">
                <h3>
                    ${peatykk.kuvatavNr}:
                    ${peatykk.peatykkPealkiri}
                </h3>
            </a>
        </li>

        <ul style="list-style-type:none;">
        %if peatykk.paragrahvid:
            % for paragrahv in peatykk.paragrahvid:
                ${makeParagrahv(paragrahv,f'{peatykk.id}.xhtml')}
            % endfor
        % elif peatykk.jaod:
            % for jagu in peatykk.jaod:
                ${makeJagu(jagu,f'{peatykk.id}.xhtml')}
            % endfor
        % endif
        </ul>

    %endfor
</ul>


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
                ${jagu.jaguPealkiri}
            </h4>
        </a>
    </li>

    <ul style="list-style-type:none;">
    % for paragrahv in jagu.paragrahvid:
        ${makeParagrahv(paragrahv,peatykkHref)}
    % endfor
    </ul>

</%def>