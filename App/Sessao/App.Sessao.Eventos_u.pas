unit App.Sessao.Eventos_u;

interface

uses App.Sessao.Eventos, Vcl.Forms;

type
  TSessaoEventos = class(TInterfacedObject, ISessaoEventos)
  private
    FForm: TForm;
  public
    procedure DoCancel;
    procedure DoOk;
    procedure DoClose;
    constructor Create(pForm: TForm);
  end;

implementation

{ TSessaoEventos }

constructor TSessaoEventos.Create(pForm: TForm);
begin
  FForm := pForm;
end;

procedure TSessaoEventos.DoCancel;
begin

end;

procedure TSessaoEventos.DoClose;
begin

end;

procedure TSessaoEventos.DoOk;
begin
  FForm.Hide;
end;

end.
