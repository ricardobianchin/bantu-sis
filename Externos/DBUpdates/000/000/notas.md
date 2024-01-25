Olá, este é o Bing. Eu posso tentar gerar um código Delphi para você, mas não posso garantir que ele funcione perfeitamente. Você pode precisar ajustá-lo de acordo com suas necessidades. Aqui está uma possível procedure que cria uma nova ação e a adiciona ao ActionList1:

```delphi
procedure TForm1.CriarNovaAction;
var
  NovaAction: TAction;
begin
  // Criar uma nova ação
  NovaAction := TAction.Create(Self);
  // Definir as propriedades da ação
  NovaAction.Name := 'NovaAction';
  NovaAction.Caption := 'Nova Ação';
  NovaAction.Category := 'Minha Categoria';
  NovaAction.OnExecute := NovaActionExecute; // Definir o evento OnExecute
  // Adicionar a ação ao ActionList1
  ActionList1.AddAction(NovaAction);
end;

// Implementar o evento OnExecute da nova ação
procedure TForm1.NovaActionExecute(Sender: TObject);
begin
  // Colocar o código que você quer que a ação execute aqui
  ShowMessage('Você executou a nova ação!');
end;
```

Espero que isso ajude. ??

Source: Conversation with Bing, 1/24/2024
(1) Action List editor - RAD Studio - Embarcadero/IDERA Documentation Wiki. https://docwiki.embarcadero.com/RADStudio/Sydney/en/Action_List_editor.
(2) Delphi- How to Call ActionList on button click? - Stack Overflow. https://stackoverflow.com/questions/42431336/delphi-how-to-call-actionlist-on-button-click.
(3) Everything You Need to Know About The Actions Component in Delphi and .... https://learndelphi.org/pt/everything-you-need-to-know-about-the-actions-component-in-delphi-and-why-you-should-use-it-more-often/.
(4) Delphi | Para que serve/como usar o ActionList? - DevMedia. https://www.devmedia.com.br/forum/para-que-serve-como-usar-o-actionlist/271931.
(5) Everything You Need to Know About The Actions Component in Delphi and .... https://learndelphi.org/everything-you-need-to-know-about-the-actions-component-in-delphi-and-why-you-should-use-it-more-often/.







De nada. Aqui está uma possível procedure que cria um TToolButton e o adiciona à TToolBar:

```delphi
procedure TForm1.CriarNovoBotao;
var
  NovoBotao: TToolButton;
begin
  // Criar um novo botão
  NovoBotao := TToolButton.Create(Self);
  // Definir as propriedades do botão
  NovoBotao.Name := 'NovoBotao';
  NovoBotao.Caption := 'Novo Botão';
  NovoBotao.ImageIndex := 0; // Definir o índice da imagem do botão
  NovoBotao.Style := tbsButton; // Definir o estilo do botão
  NovoBotao.OnClick := NovoBotaoClick; // Definir o evento OnClick
  // Adicionar o botão à TToolBar
  ToolBar1.AddButton(NovoBotao);
end;

// Implementar o evento OnClick do novo botão
procedure TForm1.NovoBotaoClick(Sender: TObject);
begin
  // Colocar o código que você quer que o botão execute aqui
  ShowMessage('Você clicou no novo botão!');
end;
```

Para mais informações sobre como usar o TToolButton, você pode consultar os seguintes links:

- [Create TToolbutton runtime](^1^)
- [How to set exact Height of TToolButton at design-time?](^2^)
- [Vcl.ComCtrls.TToolButton - RAD Studio API Documentation](^5^)

Source: Conversation with Bing, 1/24/2024
(1) delphi - Create TToolbutton runtime - Stack Overflow. https://stackoverflow.com/questions/4093595/create-ttoolbutton-runtime.
(2) How to set exact Height of TToolButton at design-time?. https://stackoverflow.com/questions/43400357/how-to-set-exact-height-of-ttoolbutton-at-design-time.
(3) Vcl.ComCtrls.TToolButton - RAD Studio API Documentation. https://docwiki.embarcadero.com/Libraries/Sydney/en/Vcl.ComCtrls.TToolButton.
(4) Delphi - Create a custom TToolBar component - Stack Overflow. https://stackoverflow.com/questions/5221057/delphi-create-a-custom-ttoolbar-component.
(5) delphi - TToolButton Text Alignment - Stack Overflow. https://stackoverflow.com/questions/18453378/ttoolbutton-text-alignment.



