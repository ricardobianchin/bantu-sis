unit Sis.Types.Times;

interface

uses System.Classes;

function ConvertGMTToTDateTime(const GMT: string): TDateTime;
function ConvertTDateTimeToGMT(const DT: TDateTime): string;
function ConvertGMTToTDateTimeStr(const GMT: string): string;
function DateTimeToSaudacao(const pDtH: TDateTime): string;
function ConvertISO8601ToTDateTimeStr(const GMT: string): string;

var
  MonthNames: TStringList;
  MascaraDate, MascaraTime: string;

implementation

uses SysUtils, DateUtils, Winapi.Windows;

function ConvertGMTToTDateTime(const GMT: string): TDateTime;
var
  Day, Month, Year, Time: string;
  DT: TDateTime;
  FormatSettings: TFormatSettings;
begin
  Day := Copy(GMT, 6, 2);
  Month := IntToStr(MonthNames.IndexOf(Copy(GMT, 9, 3)) + 1);
  Year := Copy(GMT, 13, 4);
  Time := Copy(GMT, 18, 8);

  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator := '/';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  DT := StrToDateTime(Day + '/' + Month + '/' + Year + ' ' + Time, FormatSettings);
  DT := IncHour(DT, -3); // Subtrai 3 horas

  Result := DT;
end;

function ConvertTDateTimeToGMT(const DT: TDateTime): string;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'ddd, d mmm yyyy';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';
  FormatSettings.DateSeparator := ' ';
  Result := DateTimeToStr(DT, FormatSettings);
end;

function ConvertGMTToTDateTimeStr(const GMT: string): string;
var
  Day, Month, Year, Time: string;
  DT: TDateTime;
  FormatSettings: TFormatSettings;
  //myDate, myTime: string;
begin
  Day := Copy(GMT, 6, 2);
  Month := IntToStr(MonthNames.IndexOf(Copy(GMT, 9, 3)) + 1);
  Year := Copy(GMT, 13, 4);
  Time := Copy(GMT, 18, 8);

  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator := '/';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

    DT := StrToDateTime(Day + '/' + Month + '/' + Year + ' ' + Time, FormatSettings);
{  if LowerCase(MascaraDate[1])='d' then
    DT := StrToDateTime(Day + '/' + Month + '/' + Year + ' ' + Time, FormatSettings)
  else
    DT := StrToDateTime( Month + '/' + Day + '/' +Year + ' ' + Time, FormatSettings)
    }
  DT := IncHour(DT, -3); // Subtrai 3 horas

  Result := DateTimeToStr(DT);
end;

function DateTimeToSaudacao(const pDtH: TDateTime): string;
var
  iHora: Integer;
begin
  iHora := HourOf(pDtH);

  if iHora < 12 then
    Result := 'Bom dia!'
  else if iHora < 18 then
    Result := 'Boa tarde!'
  else
    Result := 'Boa noite!';
end;

function ConvertISO8601ToTDateTimeStr(const GMT: string): string;
var
  Day, Month, Year, Time: string;
  DT: TDateTime;
  FormatSettings: TFormatSettings;
  sDtH: string;
//  sDeslocamento: string;
  //myDate, myTime: string;
begin
  Day := Copy(GMT, 9, 2);
  Month := Copy(GMT, 6, 2);
  Year := Copy(GMT, 1, 4);
  Time := Copy(GMT, 12, 8);

  sDtH := Day + '/' + Month + '/' + Year + ' ' + Time;

  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator := '/';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  DT := StrToDateTime(sDtH, FormatSettings);
  DT := IncHour(DT, -3); // Subtrai 3 horas

  Result := DateTimeToStr(DT);
end;

initialization

var
  iniFormatSettings: TFormatSettings;
  iniFormatSettings := TFormatSettings.Create;

  MonthNames := TStringList.Create;
  MonthNames.CommaText := '"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"';

//  MascaraDate := GetLocaleStr(GetThreadLocale(), LOCALE_SSHORTDATE, '');
//  MascaraTime := GetLocaleStr(GetThreadLocale(), LOCALE_STIMEFORMAT, '');

  MascaraDate := FormatSettings.ShortDateFormat;
  MascaraTime := FormatSettings.LongTimeFormat;

finalization
  MonthNames.Free;
end.
