# Análise de Impacto Veicular Frontal: Modelagem de Dummy com Sistemas Massa Mola Amortecedor

## Autores
* Gabriel Ranieri Vaz de Lima
* Caio Felipe dos Santos Oliveira

## Objetivos

O presente trabalho tem como objetivo realizar a análise da modelagem de um
impacto frontal sofrido por um automóvel a 48km/h. Nessa etapa do projeto, o
desenvolvimento realizado se concentra na cinemática do Dummy Hybrid III 50th, um
modelo comumente utilizado que tem as dimensões médias e massa média de um ser
humano do sexo masculino.
A análise utiliza como ferramenta os dados cinemáticos, como deslocamento,
velocidade e aceleração. Essas informações serão utilizadas para aplicação do critério HIC
(Head Injury Criteria), que avalia o nível dos ferimentos na cabeça dos ocupantes com base
nos dados cinemáticos da aceleração.
Para que essa análise fosse possível, foram feitas algumas simplificações no
modelo, de forma a utilizar apenas molas e amortecedores (o que também inclui molas de
torção nas juntas). Essas simplificações possibilitaram a aplicação da mecânica de
Lagrange que forneceu as equações para que a modelagem fosse realizada e
posteriormente aplicada no software Octave para sumulação dinâmica.

## Simulações no Octave

Foram desenvolvidos 4 arquivos de funções em Octave/Matlab que operam em conjunto:

* Dummy_v2.m (main): Executa o cálculo das Equações Diferencias Ordinárias e realiza o plot dos resultados;
* AccHeadDef.m: Calcula a matriz gerada pela equações de lagrange e com o resultado encontra o valor da aceleração da cabeça do Dummy;
* dydt.m: Determina as derivadas das Equações Diferenciais Ordinárias;
* hicN.m: Calcula o HIC do sistema;
