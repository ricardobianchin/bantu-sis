unit App.UI.Form.Retag.Excl_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, App.UI.Decorator.Form.Excl, Vcl.StdCtrls;

type
  TExclBasForm = class(TBasForm)
    SimButton: TButton;
    NaoButton: TButton;
    PerguntaLabel: TLabel;
    procedure NaoButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FDecoratorExcl: IDecoratorExcl;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pDecoratorExcl: IDecoratorExcl); reintroduce;
    function Perg: boolean;
  end;

function ExclFormPerg(AOwner: TComponent; pDecoratorExcl: IDecoratorExcl): boolean;

var
  ExclBasForm: TExclBasForm;

implementation

{$R *.dfm}

function ExclFormPerg(AOwner: TComponent; pDecoratorExcl: IDecoratorExcl): boolean;
begin
  ExclBasForm := TExclBasForm.Create(AOwner, pDecoratorExcl);
  try
    Result := ExclBasForm.Perg;
  finally
    ExclBasForm.Free;
  end;
end;

{ TExclBasForm }

constructor TExclBasForm.Create(AOwner: TComponent;
  pDecoratorExcl: IDecoratorExcl);
begin
  inherited Create(AOwner);
  FDecoratorExcl := pDecoratorExcl;
  Caption := FDecoratorExcl.GetCaption;
  PerguntaLabel.Caption := FDecoratorExcl.GetPergunta;
end;

procedure TExclBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #27 then
  begin
    key := #0;
    NaoButton.Click;
  end
  else if key = #13 then
  begin
    key := #0;
    SimButton.Click;
  end;
end;

procedure TExclBasForm.NaoButtonClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNo;
end;

function TExclBasForm.Perg: boolean;
begin
  Result := IsPositiveResult(ShowModal);
end;

end.
