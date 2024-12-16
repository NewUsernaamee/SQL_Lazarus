unit Unit1;

{$mode objfpc}{$H+}

interface

uses

  Classes, SysUtils, DB, memds, Forms, Controls, Graphics, Dialogs, Menus,
  DBGrids, StdCtrls, DBCtrls, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    addDisease: TButton;
    AddDeseasesToBase: TButton;
    SaveDeseasesBase: TButton;
    DataSource3: TDataSource;
    DBGrid3: TDBGrid;
    DeleteDeseasesFromBase: TButton;
    DesisesEdit: TEdit;
    SaveButtonDesis: TButton;
    deleteDisease: TButton;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    SearchByName: TLabel;
    search: TButton;
    Edit1: TEdit;
    SortByName: TButton;
    sortById: TButton;
    DeleteBTN: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    procedure birthdayChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure addDiseaseClick(Sender: TObject);
    procedure DBGrid1CellClick(Sender: TObject; ACol,ARow: Integer);
    procedure deleteDiseaseClick(Sender: TObject);
    procedure DesisesEditChange(Sender: TObject);
    procedure SaveButtonDesisClick(Sender: TObject);
    procedure SearchByNameClick(Sender: TObject);
    procedure searchClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure SortByNameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sortByIdClick(Sender: TObject);
    procedure DeleteBTNClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SNameChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

var sortIdStatus:boolean;
var sortNameStatus:boolean;

procedure TForm1.Button1Click(Sender: TObject);
begin
    try
      Unit2.DataModule1.SQLQuery1.Insert;
      ShowMessage('Запрос выполнен успешно. Данные загружены.');
      Unit2.DataModule1.SQLQuery1.Active:=TRUE;
    except
    on E: Exception do
        ShowMessage('Ошибка при выполнении запроса: ' + E.Message);
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

    Unit2.DataModule1.SQLQuery1.ApplyUpdates;
    Unit2.DataModule1.SQLQuery1.SQLTransaction.CommitRetaining;
end;

procedure TForm1.addDiseaseClick(Sender: TObject);
Var
  patientID: string;
  Desease: string;
begin
     patientID := DBGrid1.DataSource.DataSet.FieldByName(DBGrid1.Columns[0].FieldName).AsString;
     Desease:= DesisesEdit.Text;
  try
      Unit2.DataModule1.SQLQuery2.Active := False;
       Unit2.DataModule1.SQLQuery2.SQL.Text := 'Настя допиши запрос на добавление';
       Unit2.DataModule1.SQLQuery2.Active := TRUE;
      ShowMessage('Запрос выполнен успешно. Данные загружены.');
    except
    on E: Exception do
        ShowMessage('Ошибка при выполнении запроса: ' + E.Message);
    end;
end;

procedure TForm1.DBGrid1CellClick(Sender: TObject; ACol, ARow: Integer);
var
  patientID: string;
begin
  if ARow >= 0 then // Проверка на корректный номер строки
  begin

     patientID := DBGrid1.DataSource.DataSet.FieldByName(DBGrid1.Columns[0].FieldName).AsString;
    Unit2.DataModule1.SQLQuery2.Active := False;
    Unit2.DataModule1.SQLQuery2.SQL.Text :=  'SELECT diseases.deseases.deseaseName FROM diseases.deseases, diseases.patients, diseases.patients_has_deseases WHERE diseases.patients.id = diseases.patients_has_deseases.patients_id AND diseases.patients_has_deseases.deseases_diseasesCode = diseases.deseases.diseaseCode AND diseases.patients.id ='+char(39) + patientID + char(39)+';' ;
    Unit2.DataModule1.SQLQuery2.Active := TRUE;

  end;
end;

procedure TForm1.deleteDiseaseClick(Sender: TObject);
Var
  patientID: string;
  Desease: string;
begin
   if not (Unit2.DataModule1.SQLQuery1.EOF and Unit2.DataModule1.SQLQuery1.BOF) then
  begin
       patientID := DBGrid1.DataSource.DataSet.FieldByName(DBGrid1.Columns[0].FieldName).AsString;
       Desease := DBGrid1.DataSource.DataSet.FieldByName(DBGrid1.Columns[2].FieldName).AsString;
       Unit2.DataModule1.SQLQuery2.Active := False;
       Unit2.DataModule1.SQLQuery2.SQL.Text :='Настя допиши запрос на удаление';
       Unit2.DataModule1.SQLQuery2.Active := TRUE;
  end;
end;

procedure TForm1.DesisesEditChange(Sender: TObject);
begin

end;

procedure TForm1.SaveButtonDesisClick(Sender: TObject);
begin
  
    Unit2.DataModule1.SQLQuery2.ApplyUpdates;
    Unit2.DataModule1.SQLQuery2.SQLTransaction.CommitRetaining;
end;

procedure TForm1.SearchByNameClick(Sender: TObject);
begin

end;

procedure TForm1.searchClick(Sender: TObject);
var startText:string;
begin
    startText := Edit1.Text;
      Unit2.DataModule1.SQLQuery1.Locate('name',startText,[]);
end;

procedure TForm1.Edit1Change(Sender: TObject);
var startText:string;
begin
    startText := Edit1.Text;
    Unit2.DataModule1.SQLQuery1.Locate('name',startText,[loPartialKey]);
end;

procedure TForm1.SortByNameClick(Sender: TObject);
begin
  if  sortNameStatus = FALSE  then
  begin
       Unit2.DataModule1.SQLQuery1.Active := FALSE;
       Unit2.DataModule1.SQLQuery1.SQL.Text := 'SELECT * FROM patients ORDER BY name DESC'  ;
       Unit2.DataModule1.SQLQuery1.Active := TRUE;
       sortNameStatus := TRUE;
  end
  else
  begin
       Unit2.DataModule1.SQLQuery1.Active := FALSE;
       Unit2.DataModule1.SQLQuery1.SQL.Text := 'SELECT * FROM patients ORDER BY name ASC';
       Unit2.DataModule1.SQLQuery1.Active := TRUE;
       sortNameStatus := FALSE;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
     sortIdStatus := FALSE;
     sortNameStatus := FALSE;
end;

procedure TForm1.sortByIdClick(Sender: TObject);
begin
  if  sortIdStatus = FALSE  then
  begin
      Unit2.DataModule1.SQLQuery1.Active := FALSE;
      Unit2.DataModule1.SQLQuery1.SQL.Text := 'SELECT * FROM patients ORDER BY id DESC'  ;
      Unit2.DataModule1.SQLQuery1.Active := TRUE;
      sortIdStatus := TRUE;
  end
  else
  begin
      Unit2.DataModule1.SQLQuery1.Active := FALSE;
      Unit2.DataModule1.SQLQuery1.SQL.Text := 'SELECT * FROM patients ORDER BY id ASC';
      Unit2.DataModule1.SQLQuery1.Active := TRUE;
      sortIdStatus := FALSE;
  end;
end;

procedure TForm1.DeleteBTNClick(Sender: TObject);
begin
  if not (Unit2.DataModule1.SQLQuery1.EOF and Unit2.DataModule1.SQLQuery1.BOF) then
  begin
       Unit2.DataModule1.SQLQuery1.Delete;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.birthdayChange(Sender: TObject);
begin

end;

procedure TForm1.SNameChange(Sender: TObject);
begin

end;

end.

