unit Sis.UI.Frame.Status.Thread_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Status_u, Vcl.StdCtrls,
  Sis.Threads.ThreadBas_u;
type
  TThreadStatusFrame = class(TStatusFrame)
  private
    { Private declarations }
    FThreadBas: TThreadBas;
  protected
    property ThreadBas: TThreadBas read FThreadBas;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pThreadBas: TThreadBas); reintroduce;
  end;

var
  ThreadStatusFrame: TThreadStatusFrame;

implementation

{$R *.dfm}

{ TThreadStatusFrame }

constructor TThreadStatusFrame.Create(AOwner: TComponent;
  pThreadBas: TThreadBas);
begin
  inherited Create(AOwner);
  FThreadBas := pThreadBas;
end;

end.
