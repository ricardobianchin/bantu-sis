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
  ACBrPosPrinter1.Modelo := ppEscPosEpson;
  ACBrPosPrinter1.Porta := 'USB:0416, 5011';
  ACBrPosPrinter1.ColunasFonteNormal := 48;
  ACBrPosPrinter1.CortaPapel := True;
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
    ACBrPosPrinter1.Buffer.Text := sl.Text;
    ACBrPosPrinter1.Imprimir;
    ACBrPosPrinter1.Desativar;
//showmessage('a');
    SL.Clear;
    SL.Add('</corte_total>');

    ACBrPosPrinter1.Ativar;
    ACBrPosPrinter1.Buffer.Text := sl.Text;
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
