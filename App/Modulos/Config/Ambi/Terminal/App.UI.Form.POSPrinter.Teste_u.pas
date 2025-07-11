unit App.UI.Form.POSPrinter.Teste_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrPosPrinter, Vcl.StdCtrls;

type
  TPosPrinterTesteForm = class(TForm)
    ACBrPosPrinter1: TACBrPosPrinter;
    ImprimirButton: TButton;
    procedure ImprimirButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PosPrinterTesteForm: TPosPrinterTesteForm;

implementation

{$R *.dfm}

procedure TPosPrinterTesteForm.ImprimirButtonClick(Sender: TObject);
var
  SL: TStringList;
begin
  ACBrPosPrinter1.Porta := 'USB:0416, 5011';
  ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo.ppEscPosEpson;

  ACBrPosPrinter1.ArqLOG := '';
  ACBrPosPrinter1.LinhasBuffer := 0;
  ACBrPosPrinter1.LinhasEntreCupons := 0;
  ACBrPosPrinter1.EspacoEntreLinhas := 0;
  ACBrPosPrinter1.ColunasFonteNormal := 48;
  ACBrPosPrinter1.ControlePorta := False;
  ACBrPosPrinter1.CortaPapel := True;
  ACBrPosPrinter1.TraduzirTags := True;
  ACBrPosPrinter1.IgnorarTags := False;
  ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo.pc850;
  ACBrPosPrinter1.ConfigBarras.MostrarCodigo := False;
  ACBrPosPrinter1.ConfigBarras.LarguraLinha := 0;
  ACBrPosPrinter1.ConfigBarras.Altura := 0;
  ACBrPosPrinter1.ConfigQRCode.Tipo := 2;
  ACBrPosPrinter1.ConfigQRCode.LarguraModulo := 4;
  ACBrPosPrinter1.ConfigQRCode.ErrorLevel := 0;
  ACBrPosPrinter1.ConfigLogo.KeyCode1 := 32;
  ACBrPosPrinter1.ConfigLogo.KeyCode2 := 32;
  ACBrPosPrinter1.ConfigLogo.FatorX := 1;
  ACBrPosPrinter1.ConfigLogo.FatorY := 1;

  {
    ACBrPosPrinter1.Porta  := cbxPorta.Text;
    ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo( cbxModelo.ItemIndex );
    ACBrPosPrinter1.ArqLOG := edLog.Text;
    ACBrPosPrinter1.LinhasBuffer := seLinhasBuffer.Value;
    ACBrPosPrinter1.LinhasEntreCupons := seLinhasPular.Value;
    ACBrPosPrinter1.EspacoEntreLinhas := seEspLinhas.Value;
    ACBrPosPrinter1.ColunasFonteNormal := seColunas.Value;
    ACBrPosPrinter1.ControlePorta := cbControlePorta.Checked;
    ACBrPosPrinter1.CortaPapel := cbCortarPapel.Checked;
    ACBrPosPrinter1.TraduzirTags := cbTraduzirTags.Checked;
    ACBrPosPrinter1.IgnorarTags := cbIgnorarTags.Checked;
    ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo( cbxPagCodigo.ItemIndex );
    ACBrPosPrinter1.ConfigBarras.MostrarCodigo := cbHRI.Checked;
    ACBrPosPrinter1.ConfigBarras.LarguraLinha := seBarrasLargura.Value;
    ACBrPosPrinter1.ConfigBarras.Altura := seBarrasAltura.Value;
    ACBrPosPrinter1.ConfigQRCode.Tipo := seQRCodeTipo.Value;
    ACBrPosPrinter1.ConfigQRCode.LarguraModulo := seQRCodeLarguraModulo.Value;
    ACBrPosPrinter1.ConfigQRCode.ErrorLevel := seQRCodeErrorLevel.Value;
    ACBrPosPrinter1.ConfigLogo.KeyCode1 := seLogoKC1.Value;
    ACBrPosPrinter1.ConfigLogo.KeyCode2 := seLogoKC2.Value;
    ACBrPosPrinter1.ConfigLogo.FatorX := seLogoFatorX.Value;
    ACBrPosPrinter1.ConfigLogo.FatorY := seLogoFatorY.Value;
  }

  // ACBrPosPrinter1.LinhasEntreCupons := 3;

  SL := TStringList.Create;
  try
    SL.Clear;
    SL.Add('DAROS INFORMATICA');
    SL.Add('DAROS INFORMATICA2');
    SL.Add('');
    SL.Add('');
    SL.Add('');
    SL.Add('');
    SL.Add('');

    ACBrPosPrinter1.Ativar;
    ACBrPosPrinter1.Buffer.Text := SL.Text;
    ACBrPosPrinter1.Imprimir;
    ACBrPosPrinter1.Desativar;
    // showmessage('a');
    SL.Clear;
    SL.Add('</corte_total>');

    ACBrPosPrinter1.Ativar;
    ACBrPosPrinter1.Buffer.Text := SL.Text;
    ACBrPosPrinter1.Imprimir;
    ACBrPosPrinter1.Desativar;

  finally
    SL.free;
  end;
  // SLEEP(1000);

  // ACBrPosPrinter1.Ativar ;
  // ACBrPosPrinter1.Buffer.Clear;
  // ACBrPosPrinter1.Buffer.Add('</CORTE>');
  // SLEEP(1000);
  // ACBrPosPrinter1.Imprimir;
  // ACBrPosPrinter1.Desativar ;
end;

end.
