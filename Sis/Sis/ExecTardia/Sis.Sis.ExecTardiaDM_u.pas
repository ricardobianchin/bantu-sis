unit Sis.Sis.ExecTardiaDM_u;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, Sis.Types;

type
  TExecTardiaDM = class(TDataModule)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FProc: TProcedureOfObject;
  public
    { Public declarations }
    procedure Execute(pProc: TProcedureOfObject; Interval: Integer = 100);
  end;

var
  ExecTardiaDM: TExecTardiaDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TExecTardiaDM }

procedure TExecTardiaDM.Execute(pProc: TProcedureOfObject; Interval: Integer);
begin
  FProc := pProc;
  Timer1.Interval := Interval;
  Timer1.Enabled := True;
end;

procedure TExecTardiaDM.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if Assigned(FProc) then
    FProc;
end;

end.

