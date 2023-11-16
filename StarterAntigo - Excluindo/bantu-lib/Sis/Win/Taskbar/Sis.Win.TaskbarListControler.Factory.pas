unit Sis.Win.TaskbarListControler.Factory;

interface

uses Sis.Win.TaskbarListControler;

function TaskbarListControlerCreate: ITaskbarListControler;

implementation

uses Sis.Win.TaskbarListControler_u;

function TaskbarListControlerCreate: ITaskbarListControler;
begin
  Result := TTaskbarListControler.Create;
end;

end.
