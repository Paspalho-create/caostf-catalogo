# CaosTF — Catálogo de móveis (páginas estáticas)

Espelho de publicação dos 4 arquivos gerados em `..\catalogo\`.
Não editar HTML aqui: a fonte é `..\catalogo\` (gerada por `gerar-catalogo.mjs`);
depois de gerar de novo, copie e faça commit.

## Arquivos publicados

| Arquivo | Papel |
|---|---|
| `index.html` | cópia idêntica do hub (`catalogo-moveis.html`) — serve a raiz do site |
| `catalogo-moveis.html` | hub |
| `catalogo-cozinha.html` | categoria |
| `catalogo-quarto.html` | categoria |
| `catalogo-suspensos.html` | categoria |
| `robots.txt` | `Disallow: /` (link não indexado) |
| `.nojekyll` | desliga o Jekyll do GitHub Pages (publica os arquivos como estão) |

> **Não indexar:** o `robots.txt` de uma subpasta não é lido pelo Google (ele só busca `/robots.txt` na raiz do domínio).
> Por isso o `atualizar.ps1` injeta `<meta name="robots" content="noindex,nofollow,noarchive">` no `<head>` de cada página — é o que de fato bloqueia buscador.
> Também injeta um favicon `data:` inline (evita 404 de `/favicon.ico`).

## Como atualizar

```powershell
$src = "C:\Users\Sysmex\workspace_maker\catalogo"
$dst = "C:\Users\Sysmex\workspace_maker\caostf-catalogo-site"
Copy-Item "$src\catalogo-*.html" $dst -Force
Copy-Item "$src\catalogo-moveis.html" "$dst\index.html" -Force
cd $dst
git add -A
git commit -m "catalogo: atualiza paginas"
git push
```

GitHub Pages republica sozinho em ~1 minuto.

## Regras

- Sem preço, sem analytics, sem coleta de dados, sem dependência externa.
- Contato comercial: apenas o link `wa.me` já embutido nas páginas.
- Link é "não listado": `robots.txt` bloqueia buscadores; não divulgar em local público.
