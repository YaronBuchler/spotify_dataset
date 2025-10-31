# Projeto de Recomendação de Música com Neo4j

Este repositório contém um exemplo de scripts em Cypher para criar um grafo de usuários, músicas e gêneros, além de três exemplos de algoritmos de recomendação.

## Conteúdo

- `spotify_recommendations.cypher`: Script de criação de nós, relacionamentos e exemplos de recomendação.
- `datasets/`: Contém os arquivos CSV utilizados para popular o grafo.
  - `SocialMediaUsersDataset`: utilizado para criar os usuários de exemplo.
  - `spotify_tracks.csv`: utilizado para criar músicas, artistas e gêneros (colunas usadas: `music`, `artist`, `genre`).

## Observações

- O script `.cypher` é apenas um **exemplo de implementação**.
- Este projeto foi desenvolvido como ambiente de teste; os relacionamentos e dados podem não refletir situações reais.
- Imagens de exemplo do grafo podem ser encontradas na pasta `images/`.

## Como usar

1. Importe os CSVs para o Neo4j Aura ou local.
2. Execute o `.cypher` no Neo4j Browser ou Bloom.
3. Explore os exemplos de recomendação.


## Exemplo de Grafoima
![Visualização do Grafo][def]

[def]: images/Exemplo1.png
