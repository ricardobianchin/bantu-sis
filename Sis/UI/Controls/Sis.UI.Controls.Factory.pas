unit Sis.UI.Controls.Factory;

interface

uses Vcl.Forms, Sis.UI.Controls.Alinhador, Sis.UI.Controls.ComboBoxManager, Vcl.StdCtrls,
  Sis.UI.Controls.BotaoFrame_u, Vcl.Controls, System.Classes, Vcl.ImgList,
  System.UITypes, Sis.UI.Select, Sis.UI.Frame.Bas.Filtro_u, Sis.DBI;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
function ComboBoxManagerCreate(pComboBox: TComboBox): IComboBoxManager;

function BotaoFrameCreate(pParent: TWinControl; pTit, pDescr: string;
  pLeft, pTop: integer; pOnBotaoClick: TNotifyEvent;
  pImageList: TCustomImageList; pImageIndex: System.UITypes.TImageIndex;
  pTag: NativeInt): TBotaoFrame;

function DBSelectFormCreate(pDBI: IDBI; pFiltro: TFiltroFrame): ISelect;

function AndamentoFrameCreateExibe(pParent: TWinControl; pFrase: string = ''): TFrame;

implementation

uses Sis.UI.Controls.Alinhador.ADireita_u, Sis.UI.Controls.ComboBoxManager_u,
  System.SysUtils, Sis.UI.Form.Select.DB_u, Sis.UI.Controls.AndamentoFrame_u,
  Sis.UI.Controls.Utils;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
begin
  Result := TControlsAlinhadorADireita.Create;
end;

function ComboBoxManagerCreate(pComboBox: TComboBox): IComboBoxManager;
begin
  Result := TComboBoxManager.Create(pComboBox);
end;

function BotaoFrameCreate(pParent: TWinControl; pTit, pDescr: string;
  pLeft, pTop: integer; pOnBotaoClick: TNotifyEvent;
  pImageList: TCustomImageList; pImageIndex: System.UITypes.TImageIndex;
  pTag: NativeInt): TBotaoFrame;
begin
  Result := TBotaoFrame.Create(pParent);
  Result.Name := 'BotaoFrame' + pTag.ToString;
  Result.Tit := pTit;
  Result.Tit2 := pDescr;
  Result.Left := pLeft;
  Result.Top := pTop;
  Result.OnBotaoClick := pOnBotaoClick;
  Result.ImageList := pImageList;
  Result.ImageIndex := pImageIndex;
  Result.Tag := pTag;
end;

function DBSelectFormCreate(pDBI: IDBI; pFiltro: TFiltroFrame): ISelect;
begin
  Result := TDBSelectForm.Create(pDBI, pFiltro);
end;

function AndamentoFrameCreateExibe(pParent: TWinControl; pFrase: string = ''): TFrame;
begin
  Result := TAndamentoFrame.Create(nil);
  Result.Parent := pParent;
  ControlAlignToRect(Result, pParent.ClientRect);
  Result.BringToFront;
  Result.Visible := True;
  Result.Repaint;
end;

end.
