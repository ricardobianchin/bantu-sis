unit Sis.UI.IO.Output.ShowMessage_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls;

type
  TShowMessageOutput = class(TInterfacedObject, IOutput)
  private
    FAtivo: Boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    property Ativo: boolean read GetAtivo write SetAtivo;
    constructor Create;
  end;

implementation

uses Vcl.Forms, Sis.Types.Bool_u;

{ TShowMessageOutput }

constructor TShowMessageOutput.Create;
begin
  FAtivo := True;
end;

procedure TShowMessageOutput.Exibir(pFrase: string);
begin
//  ShowMessage(pFrase);
//  Application.MessageBox(PWideChar(pFrase), 'Sessão de Caixa', 0);
  ExibirPausa(pFrase, TMsgDlgType.mtInformation);
end;

procedure TShowMessageOutput.ExibirPausa(pFrase: string;
  pMsgDlgType: TMsgDlgType);
begin
//  MessageDlg(pFrase, pMsgDlgType, [mbOk], 0);
  ShowMessage(pFrase);
end;

function TShowMessageOutput.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TShowMessageOutput.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
