unit Sis.UI.IO.Input.Bool.Caption.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls,
  Sis.Types.Utils_u, Vcl.Buttons;

type
  TInputBoolCaptionForm = class(TBasForm)
    FundoPanel: TPanel;
    PerguntaLabel: TLabel;
    SimBitBtn: TBitBtn;
    NaoBitBtn: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FButtonDefault: TBooleanDefault;
  public
    { Public declarations }
    function Perg(pPergunta: string; pCaption: string = '';
      pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
  end;
function PergBool(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;

var
  InputBoolCaptionForm: TInputBoolCaptionForm;

implementation

{$R *.dfm}

function PergBool(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
var
  oInput: TInputBoolCaptionForm;
begin
  oInput := TInputBoolCaptionForm.Create(nil);
  Result := oInput.Perg(pPergunta, pCaption, pDefaultResult);
  oInput.Free;
end;


{ TInputBoolCaptionForm }

procedure TInputBoolCaptionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if key = #27 then
//  begin
//    key := #0;
//    NaoBitBtn.Click;
//  end;
end;

function TInputBoolCaptionForm.Perg(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
begin
  if pCaption = '' then
    pCaption := Application.Title;

  if pCaption = '' then
    pCaption := 'Confirmação';

  Caption := pCaption;
  PerguntaLabel.Caption := pPergunta;

  FButtonDefault := pDefaultResult;

  result := IsPositiveResult(ShowModal);
end;

procedure TInputBoolCaptionForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  case FButtonDefault of
    //boolUndefined: ;
    boolFalse: NaoBitBtn.SetFocus;
    boolTrue: SimBitBtn.SetFocus;
  end;

end;

end.
