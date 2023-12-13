unit LogMon.UI.Princ.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Act_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Grids;

type
  TLogMonForm = class(TActBasForm)
    TopoPanel: TPanel;
    ArqLabeledEdit: TLabeledEdit;
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogMonForm: TLogMonForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files;

procedure TLogMonForm.Button1Click(Sender: TObject);
const
  FILTRO = 'Arquivos de log (*.processlog.txt)|*.processlog.txt' +
    '|Arquivos texto (*.txt)|*.txt' +
    '|Todos os arquivos(*.*)|*.*'
    ;
  TITULO = 'Escolha o arquivo de log...';
var
  sNomeArqLog: string;
  bResultado: boolean;
begin
  inherited;
  sNomeArqLog := '';
  bResultado := EscolhaArquivo(sNomeArqLog, FILTRO, TITULO);
  if not bResultado then
    exit;
//         criar item, list e fazer a grid ser virtual
  ArqLabeledEdit.Text := sNomeArqLog;

end;

end.
