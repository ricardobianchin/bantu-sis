unit btu.lib.ui.FormBasico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, btu.lib.ui.FormDecorator, System.Generics.Collections;

type
  TFormBasico = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FDecorators: TList<IFormDecorator>;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  public
    constructor Create(AOwner: TComponent; ADecorators: array of IFormDecorator); reintroduce;
    { Public declarations }

  end;

var
  FormBasico: TFormBasico;

implementation

{$R *.dfm}

{ TFormBas }

procedure TFormBasico.CMTextChanged(var Message: TMessage);
var
  Item: IFormDecorator;
begin
  inherited;
  FDecorators := TList<IFormDecorator>.Create;

  for Item in FDecorators do
  begin
    Item.FormCaptionChanged(Caption);
  end;
end;

constructor TFormBasico.Create(AOwner: TComponent; ADecorators: array of IFormDecorator);
var
  Item: IFormDecorator;
begin
  FDecorators := TList<IFormDecorator>.Create;

  for Item in ADecorators do
  begin
    FDecorators.add(Item);
    Item.FormCreate;
  end;
end;

procedure TFormBasico.FormDestroy(Sender: TObject);
var
  Item: IFormDecorator;
begin
  for Item in FDecorators do
    Item.FormDestroy;
end;

procedure TFormBasico.FormKeyPress(Sender: TObject; var Key: Char);
var
  Item: IFormDecorator;
begin
  for Item in FDecorators do
    Item.FormKeyPress(Key);
end;

procedure TFormBasico.FormResize(Sender: TObject);
var
  Item: IFormDecorator;
begin
  for Item in FDecorators do
    Item.FormSize;
end;

end.
