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
    FDefaultResult: TBooleanDefault;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined);
      reintroduce;
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
  PergForm: TInputBoolCaptionForm;
begin
  PergForm := TInputBoolCaptionForm.Create(nil, pDefaultResult);

  if pCaption = '' then
    pCaption := Application.Title;

  if pCaption = '' then
    pCaption := 'Confirmação';

  PergForm.Caption := pCaption;
  PergForm.PerguntaLabel.Caption := pPergunta;

  result := IsPositiveResult(PergForm.ShowModal);
  PergForm.Free;
end;

{ TInputBoolCaptionForm }

constructor TInputBoolCaptionForm.Create(AOwner: TComponent;
  pDefaultResult: TBooleanDefault);
begin
  inherited Create(AOwner);
  FDefaultResult := pDefaultResult;
end;

procedure TInputBoolCaptionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if key = #27 then
//  begin
//    key := #0;
//    NaoBitBtn.Click;
//  end;
end;

procedure TInputBoolCaptionForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  case FDefaultResult of
    //boolUndefined: ;
    boolFalse: NaoBitBtn.SetFocus;
    boolTrue: SimBitBtn.SetFocus;
  end;

end;

end.
