unit Sis.UI.Frame.Status.Thread_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Status_u, Vcl.StdCtrls,
  Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.Threads.SafeBool,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output.ProcessLog.Factory;

type
  TThreadStatusFrame = class(TStatusFrame)
  private
    { Private declarations }
    FThreadCreator: IThreadCreator;
    FThreadBas: TThreadBas;
    FExecutandoSafeBool: ISafeBool;

    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;
  protected
    property ThreadBas: TThreadBas read FThreadBas;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure DoTerminate(Sender: TObject);
    procedure Terminate; // override;
    function PodeFechar: boolean; // override;
    property ThreadCreator: IThreadCreator read FThreadCreator
      write FThreadCreator;
    property Executando: ISafeBool read FExecutandoSafeBool;
    procedure Execute;
    property TitOutput: IOutput read FTitOutput;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessLog: IProcessLog read FProcessLog;
  end;

  TThreadStatusFrameProcedure = reference to procedure
    (pFrame: TThreadStatusFrame);

  // var
  // ThreadStatusFrame: TThreadStatusFrame;

implementation

{$R *.dfm}

uses Sis.Threads.Factory_u, Sis.UI.Controls.Utils, Sis.UI.IO.Output.ToLabel_u,
  Sis.UI.IO.Factory;

{ TThreadStatusFrame }

constructor TThreadStatusFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThreadBas := nil;
  FExecutandoSafeBool := SafeBoolCreate(False);
  ClearStyleElements(Self);
  FTitOutput := LabelSafeOutputCreate(TitLabel);
  FStatusOutput := LabelSafeOutputCreate(StatusLabel);
  FProcessLog := mudoprocesslogcreate;

end;

procedure TThreadStatusFrame.DoTerminate(Sender: TObject);
begin
  StatusOutput.Exibir('Parado');
  FThreadBas := nil;
end;

procedure TThreadStatusFrame.Execute;
var
  s: string;
begin
  s := name;
  if Executando.AsBoolean then
    exit;
  if Assigned(FThreadBas) then
    exit;

  if not Assigned(FThreadBas) then
    FThreadBas := ThreadCreator.TThreadBasCreate;
  FThreadBas.OnTerminate := DoTerminate;

  try
    if FThreadBas.Suspended then
      FThreadBas.Resume
    else
      FThreadBas.Start;
  except
    on e: exception do
      StatusOutput.Exibir(e.Message);
  end;
end;

function TThreadStatusFrame.PodeFechar: boolean;
begin
  Result := not Assigned(FThreadBas);
  if Result then
    exit;

  Result := not Executando.AsBoolean;
end;

procedure TThreadStatusFrame.Terminate;
begin
  inherited;
  // Result := not Assigned(FThreadBas);
  // if Result then
  // exit;

  if not Executando.AsBoolean then
    exit;
  FThreadBas.Terminate
end;

end.
