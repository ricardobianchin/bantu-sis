unit sis.ui.io.output.exibirpausa.form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  sis.types.constants, System.UITypes;

type
  TExibirPausaF = class(TForm)
    GeralPanel: TPanel;
    TopoPanel: TPanel;
    DlgTypeLabel: TLabel;
    MensagemMemo: TMemo;
    BasePanel: TPanel;
    Button1: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Exibir(pMensagem: string; pMsgDlgType: TMsgDlgType);

var
  ExibirPausaF: TExibirPausaF;

implementation

{$R *.dfm}

uses TypInfo;

function TMsgDlgTypeToString(DlgType: TMsgDlgType): string;
begin
  case DlgType of
    mtWarning: Result := 'Aviso!';
    mtError: Result := 'Erro!';
    mtInformation: Result := 'Informação';
    mtConfirmation: Result := 'Confirme...';
    mtCustom: Result := 'Mensagem';
  end;
end;

{
function TMsgDlgTypeToString(DlgType: TMsgDlgType): string;
begin
  Result := GetEnumName(TypeInfo(TMsgDlgType), Ord(DlgType));
end;
}

procedure Exibir(pMensagem: string; pMsgDlgType: TMsgDlgType);
begin
  ExibirPausaF := TExibirPausaF.Create(nil);
  try
    ExibirPausaF.DlgTypeLabel.Caption := TMsgDlgTypeToString(pMsgDlgType);
    ExibirPausaF.MensagemMemo.Lines.Text := pMensagem;
    ExibirPausaF.ShowModal;
  finally
    ExibirPausaF.Free;
  end;
end;

procedure TExibirPausaF.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    cENTER: Close;
    cESC: Close;
  end;
end;

end.
