unit Sis.UI.Controls.Factory;

interface

uses Sis.UI.Controls.Alinhador, Sis.UI.Controls.ComboBoxManager, Vcl.StdCtrls,
  Sis.UI.Controls.BotaoFrame_u, Vcl.Controls, System.Classes, Vcl.ImgList,
  System.UITypes;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
function ComboBoxManagerCreate(pComboBox: TComboBox): IComboBoxManager;

function BotaoFrameCreate(pParent: TWinControl; pTit, pDescr: string;
  pLeft, pTop: integer; pOnBotaoClick: TNotifyEvent; pImageList: TCustomImageList;
  pImageIndex: System.UITypes.TImageIndex; pTag: NativeInt): TBotaoFrame;

implementation

uses Sis.UI.Controls.Alinhador.ADireita_u, Sis.UI.Controls.ComboBoxManager_u;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
begin
  Result := TControlsAlinhadorADireita.Create;
end;

function ComboBoxManagerCreate(pComboBox: TComboBox): IComboBoxManager;
begin
  Result := TComboBoxManager.Create(pComboBox);
end;

function BotaoFrameCreate(pParent: TWinControl; pTit, pDescr: string;
  pLeft, pTop: integer; pOnBotaoClick: TNotifyEvent; pImageList: TCustomImageList;
  pImageIndex: System.UITypes.TImageIndex; pTag: NativeInt): TBotaoFrame;
begin
  Result := TBotaoFrame.Create(pParent);
  Result.Tit := pTit;
  Result.Tit2 := pDescr;
  Result.Left := pLeft;
  Result.Top := pTop;
  Result.OnBotaoClick := pOnBotaoClick;
  Result.ImageList := pImageList;
  Result.ImageIndex := pImageIndex;
  Result.Tag := pTag;
end;

end.
