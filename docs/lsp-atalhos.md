# Autocomplete e atalhos de LSP no Neovim

Anotações pessoais sobre como o autocomplete e o LSP foram configurados nesta
config, e o que cada atalho faz. Escrito pra eu consultar depois.

## O que é cada peça

O autocomplete de verdade precisa de duas coisas trabalhando juntas:

- **Motor de autocomplete**: a janelinha do menu que aparece enquanto digito.
  Aqui uso o **blink.cmp** (arquivo `lua/plugins/blink.lua`).
- **LSP (Language Server Protocol)**: o programa que entende a linguagem de
  verdade e sabe quais funções, variáveis e tipos existem. É ele que dá a
  inteligência. Sem LSP o autocomplete só completa palavras que já estão no texto.

Pra gerenciar os servidores LSP uso o **Mason**, que baixa cada servidor sozinho,
e o **mason-lspconfig**, que liga o Mason ao Neovim. Tudo isso está em
`lua/plugins/lsp.lua`.

Servidores configurados:

| Linguagem            | Servidor   | Precisa no sistema   |
|----------------------|------------|----------------------|
| Lua                  | lua_ls     | nada                 |
| JavaScript/TypeScript| ts_ls      | Node.js              |
| Python               | pyright    | Node.js              |
| Java                 | jdtls      | JDK 17+ (pacman: jdk-openjdk) |

Um servidor só baixa na primeira vez que abro um arquivo daquele tipo. Pra
adicionar uma linguagem nova, acrescento o nome do servidor na lista
`ensure_installed` dentro de `lua/plugins/lsp.lua`.

## Atalhos do autocomplete (blink.cmp)

- **Ctrl+y**: aceita a sugestão selecionada
- **Ctrl+espaço**: abre o menu manualmente
- **Ctrl+n / Ctrl+p**: navega pra próxima / anterior

Uso Ctrl+y de propósito pra não brigar com o **Tab**, que é do Copilot.

## Atalhos de LSP

A tecla líder (`<leader>`) aqui é o **espaço**.

### `gd` — ir pra definição

Cursor em cima de uma função ou variável e aperto `gd`. O Neovim me leva direto
pra linha onde aquilo foi criado, mesmo que seja em outro arquivo. Evita ter que
caçar o arquivo na mão.

### `K` — ver documentação (hover)

Cursor em cima de algo e aperto `K` (maiúsculo). Abre uma janelinha flutuante com
o tipo, os parâmetros e o texto de ajuda daquele item. É como passar o mouse em
cima do código num editor gráfico.

### `<leader>rn` — renomear

Espaço seguido de `rn`. Renomeia o símbolo sob o cursor em todos os lugares onde
ele aparece, inclusive em outros arquivos. Diferente de um "localizar e
substituir" comum, porque o LSP entende o escopo e não troca nomes iguais que
pertencem a outra coisa.

### `<leader>ca` — ações de código

Espaço seguido de `ca`. Abre um menu de correções e sugestões pro ponto onde está
o cursor. Exemplos: importar uma função que falta, remover variável não usada,
transformar algo numa f-string. É a "lampadinha amarela" de outros editores.

### `]d` e `[d` — pular entre erros

"Diagnostic" é o nome que o LSP dá pros avisos e erros (o sublinhado vermelho ou
amarelo). `]d` pula pro próximo problema do arquivo e `[d` volta pro anterior.

## Como os atalhos são ligados (detalhe importante)

Os atalhos de LSP só fazem sentido quando existe um servidor ativo no arquivo. Por
isso eles não ficam soltos: estão pendurados no evento **LspAttach**, que dispara
no momento em que um servidor LSP se conecta a um arquivo. Eles são definidos como
"buffer-local", ou seja, só existem naquele arquivo. Assim não atrapalham em
arquivos sem LSP, tipo um `.txt`.

## Comandos úteis pra diagnosticar

- `:Mason` — abre o gerenciador de servidores (instalar com `i`, remover com `X`)
- `:MasonInstall <servidor>` — instala um servidor direto pela linha de comando
- `:MasonLog` — mostra o log se algo falhar ao baixar
- `:LspInfo` — mostra quais servidores estão ativos no arquivo aberto
- `:checkhealth lsp` — diagnóstico geral do LSP
