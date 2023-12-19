unit App.UI.Form.Bas.Princ.Sessoes_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, App.Sessao.Criar.List;

type
  TSessoesPrincBasForm = class(TPrincBasForm)
    BasePanel: TPanel;
    DtHCompilePanel: TPanel;
    StatusPanel: TPanel;
    ScrollBox1: TScrollBox;
    TopoPanel: TPanel;
    SessaoToolBar: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FSessaoCriarList: ISessaoCriarList;
  public
    { Public declarations }
  end;

var
  SessoesPrincBasForm: TSessoesPrincBasForm;

implementation

{$R *.dfm}

uses App.Sessao.Factory;

procedure TSessoesPrincBasForm.FormCreate(Sender: TObject);
begin
  ProcessLog.PegueLocal('TSessoesPrincBasForm.FormCreate');
  try
    inherited;

    FSessaoCriarList := SessaoCriarListCreate;
    DtHCompileLabel.Parent := DtHCompilePanel;
    DtHCompileLabel.Left := 3;
    DtHCompileLabel.Top := 10;
    StatusLabel.Parent := StatusPanel;
    StatusLabel.Align := alClient;
    // StatusLabel.left := 30;
    AndamentoTitLabel.Visible := false;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TSessoesPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  ProcessLog.PegueLocal('TSessoesPrincBasForm.ShowTimer_BasFormTimer');
  try
    inherited;
    StatusOutput.Exibir('');
    ProcessOutput.Ativo := false;
    StatusMemo.Visible := false;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

end.
