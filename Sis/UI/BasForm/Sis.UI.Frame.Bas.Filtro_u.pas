unit Sis.UI.Frame.Bas.Filtro_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Sis.UI.Frame.Bas_u;

// exemplo de uso do NewArrayCreate como virtual
// no momento est� virtual; abstract;
// function TFiltroFrame.NewArrayCreate: variant;
// begin
// Result := VarArrayCreate([1, 0], varVariant);
// gera propositalmente um array ilogico que vai de 1 a 0
// end;

{
  os metodos
  procedure SetValues(Value: variant); override;
  function NewArrayCreate: variant; override;
  trabalham em conjunto e devem ser sobrescritos pensando nisto
  na classe mae,SetValues chama NewArrayCreate
}

type
  /// <summary>
  /// Frame base para filtros usados, por exemplo nos forms dataset
  /// </summary>
  ///
  /// <remarks>
  /// Agendamento vs. Execu��o Imediata:
  /// Note que o design proposto permite controlar se a atualiza��o do filtro
  /// ocorrer� ap�s um pequeno atraso, para evitar processamentos em excesso,
  /// por exemplo, durante a digitacao de uma palavra, nao deve ficar
  /// consultado o bd a cada teclada
  /// ou instantaneamente, por exemplo, quando o usuario pressiona enter
  /// ou clica em algum botao consultar
  /// </remarks>
  ///
  /// <remarks>
  /// Sobrescrita de M�todos:
  /// As fun��es SetValues, GetValues e AjusteValores est�o preparadas para
  /// serem sobrescritas. Isso d� flexibilidade ao programador para manipular
  /// os valores dos controles conforme a necessidade espec�fica do filtro
  /// implementado.
  /// </remarks>
  ///
  /// <remarks>
  /// Utiliza��o do Timer: O ChangeTimer � a pe�a chave do agendamento.
  /// Verifique se o intervalo do timer est� configurado de forma adequada no
  /// designer ou no c�digo, para que o atraso esteja dentro de um tempo
  /// aceit�vel dependendo do contexto da aplica��o.
  /// </remarks>
  ///
  /// <remarks>
  /// Essa classe deve ser herdada para criar frames que contenham controles de
  /// filtro, como TEdit.
  /// Nos eventos OnChange dos controles, recomenda-se chamar o m�todo
  /// <c>AgendeChange</c> para agendar a execu��o do evento com um intervalo de
  /// tempo, evitando processamento excessivo enquanto o usu�rio digita.
  /// Em situa��es em que a execu��o imediata � necess�ria (por exemplo, quando
  /// o usu�rio pressiona Enter), o m�todo <c>DoChange</c> deve ser chamado
  /// diretamente.
  /// O evento <c>OnChange</c> � utilizado para que a janela principal monte a
  /// SQL da consulta utilizando os valores do filtro (propriedade
  /// <c>Values</c>), consulte o banco de dados e atualize os registros exibidos
  /// no ClientDataSet.
  /// </remarks>
  TFiltroFrame = class(TBasFrame)
    AgendeChangeTimer: TTimer;

    /// <summary>
    /// Manipula o evento do timer, desabilitando-o e invocando a altera��o imediata.
    /// </summary>
    /// <param name="Sender">Objeto que disparou o evento (geralmente o timer).</param>
    procedure AgendeChangeTimerTimer(Sender: TObject);
  private
    FProcessaFiltro: Boolean;

    /// <summary>
    /// Evento que � chamado quando h� altera��o no filtro.
    /// </summary>
    FOnChange: TNotifyEvent;

    /// <summary>
    /// Recupera o evento <c>OnChange</c>.
    /// </summary>
    /// <returns>
    /// O procedimento que ser� chamado quando o filtro sofrer altera��o.
    /// </returns>
    function GetOnChange: TNotifyEvent;

    /// <summary>
    /// Atribui o evento <c>OnChange</c>.
    /// </summary>
    /// <param name="Value">
    /// Procedimento a ser chamado para tratar a altera��o.
    /// </param>
    procedure SetOnChange(const Value: TNotifyEvent);
  protected
    property ProcessaFiltro: Boolean read FProcessaFiltro write FProcessaFiltro;
    /// <summary>
    /// Atualiza os valores dos controles do filtro.
    /// </summary>
    /// <remarks>
    /// Deve ser sobrescrito pelas classes descendentes para ajustar os valores
    /// dos controles antes que estes sejam retornados pela propriedade
    /// <c>Values</c>.
    /// por exemplo, receberia um valor e faria
    /// <c>Edit1.text := Values[0];<c>
    procedure SetValues(Value: variant); virtual;

    /// <summary>
    /// Recupera os valores atuais do filtro.
    /// </summary>
    /// <returns>Um variant contendo os valores do filtro.</returns>
    /// <remarks>
    /// Antes de retornar os valores, chama-se <c>AjusteValores</c> para
    /// garantir que os controles estejam atualizados.
    /// Esse m�todo deve ser sobrescrito para retornar valores espec�ficos
    /// conforme a implementa��o dos controles. Por exemplo
    /// Values[0] := Trim(Edit1.Text);
    /// </remarks>
    function GetValues: variant; virtual;

    /// <summary>
    /// Executa o evento de altera��o imediatamente.
    /// </summary>
    /// <remarks>
    /// Chamado tanto pelo timer quanto diretamente, quando necess�rio,
    /// para executar a atualiza��o dos dados.
    /// </remarks>
    procedure DoChange;

    /// <summary>
    /// Agenda a execu��o do evento de altera��o ap�s um intervalo de tempo.
    /// </summary>
    /// <remarks>
    /// Desliga e religa o <c>ChangeTimer</c> para reiniciar a contagem do
    /// intervalo.
    /// Esse m�todo deve ser chamado, por exemplo, no OnChange dos controles do
    /// filtro.
    /// </remarks>
    procedure AgendeChange;

    /// <summary>
    /// Instancia e retorna um array Variant que armazenar� os parametros do
    /// filtro
    /// </summary>
    /// <summary>
    /// a quantidade de elementos � decidida por quem criar a classe descendente
    /// seja um frame que so manipule um parametro
    /// criar� um array que vai de 0 a 0,
    /// <c>Result := VarArrayCreate([0, 0], varVariant);</c>
    /// </summary>
    /// <returns>Um array Variant com os par�metros base.</returns>
    function NewArrayCreate: variant; virtual; abstract;

    function GetFontSize: integer; virtual;
    procedure SetFontSize(const Value: integer); virtual;
  public
    /// <summary>
    /// Realiza ajustes ou normaliza��es necess�rias nos valores do filtro.
    /// </summary>
    /// <remarks>
    /// Esse m�todo pode ser sobrescrito para executar ajustes antes que os valores sejam lidos.
    /// Geralmente, � chamado pelo <c>GetValues</c>.
    /// </remarks>
    /// por exemplo, <c>EditNome.Text := UpperCase(EditNome.Text);</c>
    /// Nao fa�a aqui o uso de Trim, senao torna impossivel o usuario
    /// digitar mais de uma palavra
    /// </remarks>
    procedure AjusteValores; virtual;
    procedure FiltroLimpar; virtual;

    /// <summary>
    /// Propriedade que encapsula os valores do filtro.
    /// </summary>
    /// <remarks>
    /// Os valores podem ser configurados ou lidos, facilitando a montagem de par�metros para consultas.
    /// </remarks>
    property Values: variant read GetValues write SetValues;
    /// <summary>
    /// Evento disparado quando ocorrer uma altera��o no filtro.
    /// </summary>
    /// <remarks>
    /// O programador deve manipular esse evento para, por exemplo, montar a SQL, consultar o banco e
    /// atualizar os registros no ClientDataSet.
    /// </remarks>
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;

    /// <summary>
    /// Cria uma inst�ncia do TFiltroFrame com o evento <c>OnChange</c> especificado.
    /// </summary>
    /// <param name="AOwner">Refer�ncia ao componente dono.</param>
    /// <param name="pOnChange">Procedimento a ser chamado quando ocorrer a altera��o do filtro.</param>
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent);
      reintroduce; virtual;

    property FontSize: integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.dfm}

{ TFiltroFrame }

procedure TFiltroFrame.AgendeChange;
begin
  AgendeChangeTimer.Enabled := False;
  AgendeChangeTimer.Enabled := True;
end;

procedure TFiltroFrame.AjusteValores;
begin
  // Implementa��o padr�o. Sobrescrever conforme necessidade.
end;

procedure TFiltroFrame.AgendeChangeTimerTimer(Sender: TObject);
begin
  AgendeChangeTimer.Enabled := False;
  DoChange;
end;

constructor TFiltroFrame.Create(AOwner: TComponent; pOnChange: TNotifyEvent);
begin
  inherited Create(AOwner);
  ProcessaFiltro := False;
  OnChange := pOnChange;
end;

procedure TFiltroFrame.DoChange;
begin
  if not ProcessaFiltro then
    exit;

  if not Assigned(FOnChange) then
    exit;

  FOnChange(Self);
end;

procedure TFiltroFrame.FiltroLimpar;
begin

end;

function TFiltroFrame.GetFontSize: integer;
begin
  Result := Font.Size;
end;

function TFiltroFrame.GetOnChange: TNotifyEvent;
begin
  Result := FOnChange;
end;

function TFiltroFrame.GetValues: variant;
begin
  AjusteValores;
  Result := NewArrayCreate;
  // Implementa��o padr�o. Subclasses devem configurar adequadamente.
  // nao pode  Result := System.Variants.Null;
  // que dar� erro fora da classe ao testar se tem ou nao elementos
end;

procedure TFiltroFrame.SetFontSize(const Value: integer);
begin
  Font.Size := Value;
end;

procedure TFiltroFrame.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TFiltroFrame.SetValues(Value: variant);
begin
  // Implementa��o padr�o vazia. Subclasses devem fornecer a implementa��o espec�fica.
end;

end.
