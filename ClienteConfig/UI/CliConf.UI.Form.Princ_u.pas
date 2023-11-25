unit CliConf.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Mask, App.AppInfo;

type
  TClienteConfigForm = class(TBasForm)
    Image1: TImage;
    CliListaArqLabeledEdit: TLabeledEdit;
    CliCodLabeledEdit: TLabeledEdit;
    Memo1: TMemo;
    ColorDialog1: TColorDialog;
    FundoColorBox: TColorBox;
    ExemploLabel: TLabel;
    FonteColorBox: TColorBox;
    FundoLabeledEdit: TLabeledEdit;
    FonteLabeledEdit: TLabeledEdit;
    ExecButton: TButton;

    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure ExecButtonClick(Sender: TObject);
    procedure FundoColorBoxChange(Sender: TObject);
    procedure FonteColorBoxChange(Sender: TObject);
    procedure FundoLabeledEditChange(Sender: TObject);
    procedure FonteLabeledEditChange(Sender: TObject);

  private
    { Private declarations }
    Versao: integer;
    TmpCliCod: integer;
    TmpFundoCor: TColor;
    TmpFonteCor: TColor;
    TmpNomeExib: string[200];


    FAppInfo: IAppInfo;

    PastaArq: string;

    FbCopiaCorSelected: boolean;
    FbCopiaCorLabeledEdit: boolean;

    procedure ControlsToAppInfo;
    procedure AppInfoToControls;

    procedure Gravar;
    procedure Ler;
  public
    { Public declarations }
  end;

var
  ClienteConfigForm: TClienteConfigForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, App.Factory;

procedure TClienteConfigForm.AppInfoToControls;
begin

end;

procedure TClienteConfigForm.ControlsToAppInfo;
begin

end;

procedure TClienteConfigForm.ExecButtonClick(Sender: TObject);
// Um método para ler um arquivo txt e retornar um TArray<string> com as informações
var
  nomeArquivo: string;
  stream: TFileStream; // Um stream para ler o arquivo
  reader: TStreamReader; // Um leitor para ler o stream
  linha: string; // Uma variável para armazenar cada linha do arquivo
  dados: TArray<string>; // Um array para armazenar os dados
  i: Integer; // Um contador para o loop

begin
  nomeArquivo := CliListaArqLabeledEdit.Text;
  TmpCliCod := strtoint(CliCodLabeledEdit.Text);

  PastaArq := Sis.UI.IO.Files.GetPastaDoArquivo(nomeArquivo);

  stream := TFileStream.Create(nomeArquivo, fmOpenRead);
  try
    reader := TStreamReader.Create(stream);
    try
      // Ler a primeira linha e ignorá-la, pois é o título
      reader.ReadLine;

      // Inicializar o array de dados
      dados := [];

      while not reader.EndOfStream do
      begin
        linha := reader.ReadLine;
        dados := linha.Split([';']);
        if strtoint(dados[0]) = TmpCliCod then
        begin
          //   0      1               2       3          4
          //clicod;versao_config;corfundo;corfonte;nome adm exib

          Versao := StrToInt(dados[1]);
          TmpFundoCor := StrToInt(dados[2]);
          TmpFonteCor := StrToInt(dados[3]);
          TmpNomeExib := UTF8EncodeToShortString( dados[4]);
          break;
        end;
      end;
    finally
      reader.Free;
    end;
    Gravar;
    Ler;
    Memo1.Lines.Clear;
    Memo1.Lines.Add('Versao='+Versao.ToString);
    Memo1.Lines.Add('CliCod='+TmpCliCod.ToString);
    Memo1.Lines.Add('FundoCor='+IntToHex(TmpFundoCor,8));
    Memo1.Lines.Add('FonteCor='+IntToHex(TmpFonteCor,8));
    Memo1.Lines.Add('NomeExib='+TmpNomeExib);

  finally
    stream.Free;
  end;
end;

procedure TClienteConfigForm.FonteColorBoxChange(Sender: TObject);
begin
  inherited;
  if not FbCopiaCorSelected then
    exit;

  ExemploLabel.Font.Color := FonteColorBox.Selected;

  FbCopiaCorLabeledEdit := false;
  FonteLabeledEdit.Text := '$'+IntToHex($00FFFFFF and ExemploLabel.Font.Color,6);
  FbCopiaCorLabeledEdit := True;


end;

procedure TClienteConfigForm.FonteLabeledEditChange(Sender: TObject);
var
  sCorDigitada: string;
  iCorDigitada: TColor;
begin
  inherited;
  if not FbCopiaCorLabeledEdit then
    exit;

  sCorDigitada := FonteLabeledEdit.Text;
  iCorDigitada := StrToInt(sCorDigitada);

  FonteColorBox.Selected := iCorDigitada;

  ExemploLabel.Font.Color := iCorDigitada;
end;

procedure TClienteConfigForm.FormCreate(Sender: TObject);
begin
  inherited;
  DisparaShowTimer := true;

  FbCopiaCorSelected := false;
  FbCopiaCorLabeledEdit := false;
  FAppInfo := AppInfoCreate(Application.ExeName);

  FundoColorBox.Selected := ExemploLabel.Color;
  FonteColorBox.Selected := ExemploLabel.Font.Color;

  FundoLabeledEdit.Text := '$'+IntToHex($00FFFFFF and ExemploLabel.Color,6);
  FonteLabeledEdit.Text := '$'+IntToHex($00FFFFFF and ExemploLabel.Font.Color,6);
end;

procedure TClienteConfigForm.FundoColorBoxChange(Sender: TObject);
begin
  inherited;
  if not FbCopiaCorSelected then
    exit;

  ExemploLabel.Color := FundoColorBox.Selected;

  FbCopiaCorLabeledEdit := false;
  FundoLabeledEdit.Text := '$'+IntToHex($00FFFFFF and ExemploLabel.Color,6);
  FbCopiaCorLabeledEdit := True;

end;

procedure TClienteConfigForm.FundoLabeledEditChange(Sender: TObject);
var
  sCorDigitada: string;
  iCorDigitada: TColor;
begin
  inherited;
  if not FbCopiaCorLabeledEdit then
    exit;

  sCorDigitada := FundoLabeledEdit.Text;
  iCorDigitada := StrToInt(sCorDigitada);

  FundoColorBox.Selected := iCorDigitada;

  ExemploLabel.Color := iCorDigitada;
end;

procedure TClienteConfigForm.Gravar;
var
  Stream: TFileStream;
  Arquivo: string;
begin
  Arquivo := PastaArq + 'App.bin';

  Stream := TFileStream.Create(Arquivo, fmCreate or fmOpenWrite);
  try
    Stream.Write(Versao, SizeOf(Integer));

    Stream.Write(TmpCliCod, SizeOf(TmpCliCod));
    Stream.Write(TmpFundoCor, SizeOf(TColor));
    Stream.Write(TmpFonteCor, SizeOf(TColor));
    Stream.Write(TmpNomeExib[1], 200);
  finally
    Stream.Free;
  end;
end;

procedure TClienteConfigForm.Ler;
var
  Stream: TFileStream;
  Arquivo: string;
begin
  Arquivo := PastaArq + 'App.bin';

  Stream := TFileStream.Create(Arquivo, fmOpenRead);
  try
    Stream.Read(Versao, SizeOf(Integer));
    Stream.Read(TmpCliCod, SizeOf(TmpCliCod));
    Stream.Read(TmpFundoCor, SizeOf(TColor));
    Stream.Read(TmpFonteCor, SizeOf(TColor));
    Stream.Read(TmpNomeExib[1], 200);
  finally
    Stream.Free;
  end;
end;

procedure TClienteConfigForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FbCopiaCorSelected := True;
  FbCopiaCorLabeledEdit := True;

end;

end.
