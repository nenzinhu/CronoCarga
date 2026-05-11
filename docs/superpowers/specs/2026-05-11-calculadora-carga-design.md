# Design Spec: Calculadora de Carga (Refatoração Visual)

## Visão Geral
Refatoração da interface da Calculadora de Carga para um modelo de fluxo guiado, informativo e detalhado, utilizando princípios de Material Design 3 e estética premium.

## Arquitetura Visual
- **Fluxo:** Card central de ação que evolui após a interação.
- **Tipografia:** Hierarquia clara usando Google Fonts (Roboto/Open Sans).
- **Sombras:** Uso de multi-layered dropshadows para efeito "lifted".
- **Feedback Visual:** Barra de ocupação de carga com cores semânticas (verde/amarelo/vermelho).

## Componentes
1. **Header:** Título e tema.
2. **Action Card:** Container central com:
   - Dropdown de veículos com ícones.
   - Campos de input (Tara/Carga).
   - Botão de cálculo com efeito glow.
3. **Detail Summary:** Card expansível exibindo PBT, carga líquida e status de segurança.

## Regras de Negócio
- A aplicação deve validar se o peso total excede a capacidade do veículo.
- Feedback visual imediato sobre a segurança da carga.

## UX
- Fluxo guiado que reduz a carga cognitiva, mostrando apenas o necessário em cada estado.
