unit App.UI.Frame.Bas.EstFiltro_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.Filtro_u, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls,
  Vcl.ToolWin, Sis.UI.Fram.Control.DtHFaixaFrame_u;

type
  TEstFiltroFrame = class(TFiltroFrame)
    FundoPanel: TPanel;
    ErroLabel: TLabel;
    TitPanel: TPanel;
    TitLabel: TLabel;
    TitToolBar: TToolBar;
    TitFecharToolButton: TToolButton;
  private
    { Private declarations }
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    function NewArrayCreate: variant; override;
  public
    { Public declarations }
    DtHFaixaFrame: TDtHFaixaFrame;
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent);
      override;
  end;

var
  EstFiltroFrame: TEstFiltroFrame;

implementation

{$R *.dfm}

{ TEstFiltroFrame }

constructor TEstFiltroFrame.Create(AOwner: TComponent; pOnChange: TNotifyEvent);
begin
  inherited;
  DtHFaixaFrame := TDtHFaixaFrame.Create(FundoPanel);
  DtHFaixaFrame.Top := TitPanel.Top + TitPanel.Height + 3;
  DtHFaixaFrame.Left := TitLabel.Left;
  DtHFaixaFrame.Dias30ToolButton.Click;
  ErroLabel.Caption := '';
end;

function TEstFiltroFrame.GetValues: variant;
begin
  Result := inherited;
  Result[0] := DtHFaixaFrame.DtIniFrame.Value;
  Result[1] := DtHFaixaFrame.DtFinFrame.Value;
end;

function TEstFiltroFrame.NewArrayCreate: variant;
begin
  Result := VarArrayCreate([0, 1], varVariant);
end;

procedure TEstFiltroFrame.SetValues(Value: variant);
begin
  inherited;
  DtHFaixaFrame.DtIniFrame.Value := Value[0];
  DtHFaixaFrame.DtFinFrame.Value := Value[1];
end;

end.
