unit Sis.UI.Frame.Status.Thread_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Status_u, Vcl.StdCtrls,
  Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.Threads.SafeBool;

type
  TThreadStatusFrame = class(TStatusFrame)
  private
    { Private declarations }
    FThreadCreator: IThreadCreator;
    FThreadBas: TThreadBas;
    FExecutandoSafeBool: ISafeBool;
  protected
    property ThreadBas: TThreadBas read FThreadBas;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pThreadCreator: IThreadCreator; pExecutandoSafeBool: ISafeBool);
      reintroduce;
    procedure PrevineFechamento; override;
    function PodeFechar: boolean; override;
  end;

var
  ThreadStatusFrame: TThreadStatusFrame;

implementation

{$R *.dfm}
{ TThreadStatusFrame }

constructor TThreadStatusFrame.Create(AOwner: TComponent;
  pThreadCreator: IThreadCreator; pExecutandoSafeBool: ISafeBool);
begin
  inherited Create(AOwner);
  FThreadBas := nil;
  FThreadCreator := pThreadCreator;
  FExecutandoSafeBool := pExecutandoSafeBool;
end;

function TThreadStatusFrame.PodeFechar: boolean;
begin
  Result := not Assigned(FThreadBas);
  if Result then
    exit;

  Result := not FThreadBas.Executando;
  if Result then
    exit;

  FThreadBas.WaitFor;
  Result := True;
end;

procedure TThreadStatusFrame.PrevineFechamento;
begin
  inherited;

end;

end.
