unit App.Sessao.EventosDeSessao_u;

interface

uses App.Constants, App.Sessao.EventosDeSessao, Vcl.Forms, App.UI.Sessoes.Frame_u;

type
  TEventosDeSessao = class(TInterfacedObject, IEventosDeSessao)
  private
    FForm: TForm;
    FSessoesFrame: TSessoesFrame;
  public
    procedure DoCancel;
    procedure DoOk;
    procedure DoAposModuloOcultar;
    procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
    procedure DoFecharSessao(pSessaoIndex: TSessaoIndex);
    procedure DoAbrirSessao(pSessaoIndex: TSessaoIndex);

    procedure Pegar(pForm: TObject; pSessoesFrame: TObject);
  end;

implementation

uses App.Sessao;

{ TEventosDeSessao }

procedure TEventosDeSessao.Pegar(pForm: TObject; pSessoesFrame: TObject);
begin
  FForm := TForm(pForm);
  FSessoesFrame := TSessoesFrame(pSessoesFrame);
end;

procedure TEventosDeSessao.DoAbrirSessao(pSessaoIndex: TSessaoIndex);
var
  iSessaoVisivelIndex: TSessaoIndex;
  oSessao: ISessao;
  oModuloBasForm: TForm;
begin
  iSessaoVisivelIndex := FSessoesFrame.GetSessaoVisivelIndex;

  if iSessaoVisivelIndex <> SESSAO_INDEX_INVALIDO then
  begin
    FSessoesFrame[iSessaoVisivelIndex].EscondaModuloForm;
  end;
  oSessao := FSessoesFrame[pSessaoIndex];
  oModuloBasForm := oSessao.ModuloBasForm;
  oModuloBasForm.Show;
  DoOk;
end;

procedure TEventosDeSessao.DoAposModuloOcultar;
begin
  //FForm.Show;
end;

procedure TEventosDeSessao.DoCancel;
begin
  // por hora, nada
end;

procedure TEventosDeSessao.DoFecharSessao(pSessaoIndex: TSessaoIndex);
begin
  FSessoesFrame.DeleteByIndex(pSessaoIndex);
//  FForm.Show;
end;

procedure TEventosDeSessao.DoOk;
begin
  FForm.Hide; // Esconde o formulário
end;

procedure TEventosDeSessao.DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
begin
//  FSessoesFrame.DoTrocarDaSessao(pSessaoIndex);
  FForm.Show;
end;

end.
