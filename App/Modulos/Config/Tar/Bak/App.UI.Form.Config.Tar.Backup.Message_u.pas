unit App.UI.Form.Config.Tar.Backup.Message_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw,
  Winapi.ActiveX, MSHTML;

type
  TBackupMessageForm = class(TDiagBasForm)
    WebBrowser1: TWebBrowser;
    BasePanel: TPanel;
    CopyNamesButton: TButton;
    PastaExplorarButton: TButton;
    FecharButton: TButton;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FecharButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PastaExplorarButtonClick(Sender: TObject);
    procedure CopyNamesButtonClick(Sender: TObject);
  private
    { Private declarations }
    FNomesFBKSL: TStringList;
    procedure LoadHTML(WebBrowser: TWebBrowser; const HTML: string);
    function GetHtml: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pNomesFBKSL: TStrings); reintroduce;
    destructor Destroy; override;
  end;

procedure BakMessageExibir(pNomesFBKSL: TStrings);

// var
// BackupMessageForm: TBackupMessageForm;

implementation

{$R *.dfm}

uses Sis.Win.Utils_u;

procedure BakMessageExibir(pNomesFBKSL: TStrings);
var
  BackupMessageForm: TBackupMessageForm;
begin
  BackupMessageForm := TBackupMessageForm.Create(nil, pNomesFBKSL);
  try
    BackupMessageForm.ShowModal;
  finally
    BackupMessageForm.Free;
  end;

end;
{ TBackupMessageForm }

procedure TBackupMessageForm.PastaExplorarButtonClick(Sender: TObject);
begin
  inherited;
  PastaExplorarButton.Enabled := False;
  try
    Application.ProcessMessages;
    ExplorerPasta(ExtractFilePath(FNomesFBKSL[0]));
    Sleep(200);
  finally
    PastaExplorarButton.Enabled := True;
  end;
end;

procedure TBackupMessageForm.FecharButtonClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TBackupMessageForm.CopyNamesButtonClick(Sender: TObject);
begin
  inherited;
  CopyNamesButton.Enabled := False;
  try
    Application.ProcessMessages;
    CopyTextToClipboard(FNomesFBKSL.Text);
    Sleep(200);
  finally
    CopyNamesButton.Enabled := True;
  end;
end;

constructor TBackupMessageForm.Create(AOwner: TComponent;
  pNomesFBKSL: TStrings);
begin
  inherited Create(AOwner);
  FNomesFBKSL := TStringList.Create;
  FNomesFBKSL.Text := pNomesFBKSL.Text;
end;

destructor TBackupMessageForm.Destroy;
begin
  FNomesFBKSL.Free;
  inherited;
end;

procedure TBackupMessageForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  case key of
    'A', 'a':
    begin
      PastaExplorarButton.Click;
    end;
    'C', 'c':
    begin
      CopyNamesButton.Click;
    end;
  end;
end;

function TBackupMessageForm.GetHtml: string;
var
  i: integer;
begin
  Result := '<!DOCTYPE html>'#13#10 +
    '<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-BR" ' +
    'xml:lang="pt-BR">'#13#10 + '<head>'#13#10 +
    '    <meta charset="utf-8" />'#13#10 + '    <style>'#13#10 + //
    '        html {'#13#10 + '            color: #1a1a1a;'#13#10 + //
    '            background-color: #fdfdfd;'#13#10 + //
    '        }'#13#10 + //
    '        body {'#13#10 + //
    '            margin: 0 auto;'#13#10 + //
    '            max-width: 50em;'#13#10 + //
    '            padding-left: 5px;'#13#10 + //
    '            padding-right: 5px;'#13#10 + //
    '            padding-top: 5px;'#13#10 + //
    '            padding-bottom: 5px;'#13#10 + //
    '            hyphens: auto;'#13#10 + //
    '            overflow-wrap: break-word;'#13#10 + //
    '            text-rendering: optimizeLegibility;'#13#10 + //
    '            font-kerning: normal;'#13#10 + //
    '            font-family: ''Segoe UI'', ''Liberation Sans'', ' +
    '''DejaVu Sans'', ''Bitstream Vera Sans'', ''Verdana'', sans-serif;'#13#10 +
    '            font-size: 1em;'#13#10 + //
    '        }'#13#10 + //
    '    </style>'#13#10 + //
    '</head>'#13#10 + //
    '<body>'#13#10 + //
    '    <p>O Comando de backup foi iniciado. Quando terminar, os ' +
    'seguintes arquivos terão sido criados:</p>'#13#10 //
    + '    <ul>'#13#10;

  for i := 0 to FNomesFBKSL.count - 1 do
    Result := Result + '<li>' + FNomesFBKSL[i] + '</li>';

  Result := Result + //
    '    </ul>'#13#10 + //
    '</body>'#13#10 + //
    '</html>'#13#10;
end;

procedure TBackupMessageForm.LoadHTML(WebBrowser: TWebBrowser;
  const HTML: string);
var
  Doc: Variant;
  MS: TStringStream;
begin
  if NOT Assigned(WebBrowser.Document) then
    WebBrowser.Navigate('about:blank');

  while WebBrowser.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

  Doc := WebBrowser.Document;
  Doc.Clear;
  Doc.Write(HTML);
  Doc.Close;
  {
    MS := TStringStream.Create(HTML, TEncoding.UTF8);
    try
    v := Null;
    WebBrowser.Navigate('about:blank');
    // Garante que o documento está carregado
    while WebBrowser.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

    (WebBrowser.Document as IHTMLDocument2).
    write(PSafeArray(TVarData(v).VArray));
    (WebBrowser.Document as IHTMLDocument2).close;
    finally
    MS.Free;
    end;
  }
end;

procedure TBackupMessageForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := GetHtml;
  LoadHTML(WebBrowser1, s);
  FecharButton.SetFocus;
end;

end.
