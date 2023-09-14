*** Settings ***
Library  Browser    timeout=15



*** Variables ***
&{PAGES}
...   ACOMPANHAMENTO=#relaxation 
...   NEW=#btn_nbusca
...   LUPA=(//i[@class='ic-busca-out'])[2]
...   LUPA2=(//i[@class='ic-busca-out'])[1]
...   CEPNAOLOCALIZADO=div#mensagem-resultado-alerta>h6
...   CEPLOCALIZADO=//th[@data-th='Logradouro/Nome']
...   LOCALIZAOBJ=#objetos
...   RASTREAMENTO=div#titulo-pagina>h3


*** Keywords ***

Abrir Navegador
    Browser.Open Browser  https://www.correios.com.br/    chromium
    

Dado que eu estou no site dos Correios
    Wait For Elements State   ${PAGES.ACOMPANHAMENTO}    visible
    Browser.Get Title     ==     Correios
    Browser.Delete all cookies
    Browser.Set Viewport Size    1920    1080
    Browser.Take Screenshot

Quando Eu procuro pelo CEP "${CEP}"
    Browser.Wait For Elements State  ${PAGES.ACOMPANHAMENTO}    visible
    Browser.Type Text   ${PAGES.ACOMPANHAMENTO}    ${CEP}
    Browser.Take Screenshot

E clico em pesquisar
    Browser.Click    ${PAGES.LUPA}
    Browser.Take Screenshot

E clico em buscar
    Browser.Click    ${PAGES.LUPA2}
    Browser.Take Screenshot

Então o sistema deve confirmar que o CEP não existe   
    ${previous} =    Switch Page      NEW
    Browser.Wait For Elements State  ${PAGES.NEW}    visible
    Browser.Take Screenshot
    Browser.Set Viewport Size    1920    1080
    Browser.Wait For Elements State  ${PAGES.CEPNAOLOCALIZADO}    visible
    Browser.Take Screenshot
    

E volto para tela inicial
    Browser.Close Page    ACTIVE
    Browser.Take Screenshot

Então o sistema deve retornar "Rua Quinze de Novembro"
    ${previous} =    Switch Page      NEW
    Browser.Set Viewport Size    1920    1080
    Browser.Wait For Elements State  ${PAGES.NEW}    visible
    Browser.Take Screenshot
    Browser.Wait For Elements State  ${PAGES.CEPLOCALIZADO}    visible
    Browser.Take Screenshot
        
Quando Eu procuro pelo código de rastreamento "${PROTOCOL}"
    Browser.Wait For Elements State  ${PAGES.LOCALIZAOBJ}    visible
    Browser.Type Text   ${PAGES.ACOMPANHAMENTO}    ${PROTOCOL}
    Browser.Press Keys    Enter
    Browser.Take Screenshot

Então sou direionado para nova pagina para confirmar que o código não está correto
    ${previous} =    Switch Page      NEW
    Browser.Set Viewport Size    1920    1080
    Browser.Take Screenshot
    Browser.Wait For Elements State  ${PAGES.RASTREAMENTO}    visible

E fecho o navegador
    Browser.Close Browser