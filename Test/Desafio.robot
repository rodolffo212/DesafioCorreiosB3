*** Settings ***

Resource  ../Page/PageObject.robot

Suite Setup    Abrir Navegador


*** Test Cases ***

Cenario 01: Verificar CEP inexistente
    [TAGS]  BUSCA CEP
  Dado que eu estou no site dos Correios
  Quando Eu procuro pelo CEP "80700000"
  E clico em pesquisar
  Então o sistema deve confirmar que o CEP não existe
  E volto para tela inicial


Cenario 02: Verificar CEP existente
    [TAGS]  BUSCA CEP
  Dado que eu estou no site dos Correios
  Quando Eu procuro pelo CEP "01013-001"
  E clico em pesquisar
  Então o sistema deve retornar "Rua Quinze de Novembro"
  E volto para tela inicial

Cenario 03: Verificar código de rastreamento incorreto
    [TAGS]  BUSCA OBJETO
  Dado que eu estou no site dos Correios
  Quando Eu procuro pelo código de rastreamento "SS987654321BR"
  E clico em buscar
  Então sou direionado para nova pagina para confirmar que o código não está correto
  E fecho o navegador