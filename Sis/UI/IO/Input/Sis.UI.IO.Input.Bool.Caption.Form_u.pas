unit Sis.UI.IO.Input.Bool.Caption.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.UI.IO.Input.Bool.Caption, Vcl.StdCtrls,
  Sis.Types.Utils_u, Vcl.Buttons;

type
  TInputBoolCaptionForm = class(TBasForm, IInputBooleanCaption)
    FundoPanel: TPanel;
    PerguntaLabel: TLabel;
    SimBitBtn: TBitBtn;
    NaoBitBtn: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function Perg(pPergunta: string; pCaption: string = '';
      pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
  end;

var
  InputBoolCaptionForm: TInputBoolCaptionForm;

implementation

{$R *.dfm}

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
  Caption := pCaption;
  PerguntaLabel.Caption := pPergunta;
  case pDefaultResult of
    //boolUndefined: ;
    boolFalse: NaoBitBtn.SetFocus;
    boolTrue: SimBitBtn.SetFocus;
  end;
  result := IsPositiveResult(ShowModal);
end;

end.
