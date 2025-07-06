unit App.UI.Form.Perg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Sis.Types.Utils_u;

type
  TPergForm = class(TBasForm)
    Panel1: TPanel;
    PerguntaLabel: TLabel;
    SimBitBtn: TBitBtn;
    NaoBitBtn: TBitBtn;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FDefaultResult: TBooleanDefault;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined);
      reintroduce;
  end;

function Perg(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): Boolean;

// var
// PergForm: TPergForm;

implementation

{$R *.dfm}

function Perg(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): Boolean;
var
  PergForm: TPergForm;
begin
  PergForm := TPergForm.Create(nil, pDefaultResult);

  if pCaption = '' then
    pCaption := Application.Title;

  if pCaption = '' then
    pCaption := 'Confirmação';

  PergForm.Caption := pCaption;
  PergForm.PerguntaLabel.Caption := pPergunta;

  result := IsPositiveResult(PergForm.ShowModal);
  PergForm.Free;
end;

{ TPergForm }

constructor TPergForm.Create(AOwner: TComponent;
  pDefaultResult: TBooleanDefault);
begin
  inherited Create(AOwner);
  FDefaultResult := pDefaultResult;
end;

procedure TPergForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  case FDefaultResult of
    // boolUndefined: ;
    boolFalse:
      NaoBitBtn.SetFocus;
    boolTrue:
      SimBitBtn.SetFocus;
  end;
end;

end.
