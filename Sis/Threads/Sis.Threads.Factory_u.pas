unit Sis.Threads.Factory_u;

interface

uses Sis.Threads.SafeBool, Sis.Threads.Crit.CriticalSections,
  Sis.Threads.Tarefa,
  Sis.UI.Frame.Status.Thread_u, Vcl.Controls;

function SafeBoolCreate(pValorInicial: Boolean = false): ISafeBool;
function CriticalSectionsCreate: ICriticalSections;
function ThreadFrameCreate(pParent: TWinControl): TThreadStatusFrame;

implementation

uses Sis.Threads.SafeBool_u, Sis.Threads.Crit.CriticalSections_u,
  Sis.Threads.Tarefa_u, System.SysUtils;

function SafeBoolCreate(pValorInicial: Boolean = false): ISafeBool;
begin
  Result := TSafeBool.Create(pValorInicial);
end;

function CriticalSectionsCreate: ICriticalSections;
begin
  Result := TCriticalSections.Create;
end;

function ThreadFrameCreate(pParent: TWinControl): TThreadStatusFrame;
begin
  Result := TThreadStatusFrame.Create(pParent);
  Result.Name := 'ThreadStatusFrame' + pParent.ControlCount.ToString;
  Result.Parent := pParent;
end;

end.
