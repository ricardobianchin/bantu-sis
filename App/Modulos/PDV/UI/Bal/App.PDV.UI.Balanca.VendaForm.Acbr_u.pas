unit App.PDV.UI.Balanca.VendaForm.Acbr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.PDV.UI.Balanca.VendaForm_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, ACBrBase, ACBrBAL, SIs.Terminal;

type
  TBalancaAcbrVendaForm = class(TBalancaVendaForm)
    ACBrBAL1: TACBrBAL;
    RespostaLabel: TLabel;
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
  private
    { Private declarations }
    FTerminal: ITerminal;
    FPastaLog: string;
    procedure InicializarBalanca(Ativar: Boolean);
    function GetNomeArqLog: string;
    function Converte(cmd: String): String;

  protected
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean;
      out pMensagem: string); override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTerminal: ITerminal); reintroduce;
  end;

var
  BalancaAcbrVendaForm: TBalancaAcbrVendaForm;

implementation

{$R *.dfm}

uses ACBrDeviceSerial, SIs.UI.IO.Serial.Utils_u, SIs.UI.IO.Files,
  SIs.Types.Floats;

{ TBalancaAcbrVendaForm }

procedure TBalancaAcbrVendaForm.ACBrBAL1LePeso(Peso: Double;
  Resposta: AnsiString);
var
  valid: Integer;
  sPeso: string;
begin
  sPeso := formatFloat('##0.000', Peso);
  RespostaLabel.Caption := Converte(String(Resposta));

  if Peso > 0 then
  begin
    PesoCurrency := Peso;
    Mensagem := 'Leitura OK!';
    StatusOutput.Exibir(sPeso);
    DeuErro := False;
  end
  else
  begin
    DeuErro := True;
    valid := Trunc(ACBrBAL1.UltimoPesoLido);
    case valid of
      0:
        Mensagem := 'Balan�a, coloque o produto';
      -1:
        Mensagem := 'Balan�a, peso inst�vel. Tente novamente';
      -2:
        Mensagem := 'Balan�a, peso negativo';
      -10:
        Mensagem := 'Balan�a, Sobrepeso';
    end;
  end;
end;

function TBalancaAcbrVendaForm.Converte(cmd: String): String;
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
     if not (CharInSet(cmd[A], ['A'..'Z','a'..'z','0'..'9',
                        ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                        '\','|','=','+','-','_',')','(','*','&','^','%','$',
                        '#','@','!','~' ])) then
        Result := Result + '#' + IntToStr(ord( cmd[A] )) + ' '
     else
        Result := Result + cmd[A] + ' ';
  end ;
end;

constructor TBalancaAcbrVendaForm.Create(AOwner: TComponent;
  pTerminal: ITerminal);
begin
  inherited Create(AOwner);
  FTerminal := pTerminal;
  FPastaLog := GetPastaDoArquivo(ParamStr(0));
  FPastaLog := PastaAcima(FPastaLog) + 'Tmp\PDV\Bal\';
  GarantaPasta(FPastaLog);
end;

function TBalancaAcbrVendaForm.GetNomeArqLog: string;
begin
  Result := FPastaLog + 'Bal Log ' + DateToNomeArq(Date) + '.txt';
end;

procedure TBalancaAcbrVendaForm.InicializarBalanca(Ativar: Boolean);
begin
  ACBrBAL1.Desativar;

  if Ativar then
  begin
    // configura porta de comunica��o
    ACBrBAL1.Modelo := TACBrBALModelo(FTerminal.BalancaId);
    ACBrBAL1.Device.HandShake := TACBrHandShake(FTerminal.BALANCA_HANDSHAKING);
    ACBrBAL1.Device.Parity := TACBrSerialParity(FTerminal.BALANCA_PARIDADE);
    ACBrBAL1.Device.Stop := TACBrSerialStop(FTerminal.BALANCA_STOPBITS);
    ACBrBAL1.Device.Data := PortaDataBits[FTerminal.BALANCA_DATABITS];
    ACBrBAL1.Device.Baud := PortaBaudRates[FTerminal.BALANCA_BAUDRATE];
    ACBrBAL1.Device.Porta := PortaNomes[FTerminal.BALANCA_PORTA];
    ACBrBAL1.ArqLOG := GetNomeArqLog;

    // Conecta com a balan�a
    ACBrBAL1.Ativar;
  end;
end;

procedure TBalancaAcbrVendaForm.LePeso(out pPeso: Currency;
  out pDeuErro: Boolean; out pMensagem: string);
const
  TimeOut = 2000;
begin
  // inherited;
  InicializarBalanca(True);
  try
    ACBrBAL1.LePeso(TimeOut);
  finally
    InicializarBalanca(False);
  end;
end;

end.
