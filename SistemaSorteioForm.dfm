object fmSistemaSorteio: TfmSistemaSorteio
  Left = 0
  Top = 0
  Caption = 'Sorteio Taif'
  ClientHeight = 717
  ClientWidth = 942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object paSuperior: TPanel
    Left = 0
    Top = 0
    Width = 942
    Height = 209
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbTipoFiltro: TLabel
      Left = 8
      Top = 24
      Width = 51
      Height = 15
      Caption = 'Filtro por:'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lbTitulo: TLabel
      Left = 2
      Top = 186
      Width = 125
      Height = 19
      Caption = 'Resumo por vendas:'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object cbTipoFiltros: TComboBox
      Left = 8
      Top = 40
      Width = 273
      Height = 23
      BevelInner = bvNone
      BevelOuter = bvNone
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Modelos de carros'
      OnChange = cbTipoFiltrosChange
      Items.Strings = (
        'Modelos de carros'
        'Pessoas'
        'Hist'#243'rico de vendas'
        'Clientes sorteados')
    end
    object caFiltros: TCardPanel
      Left = 304
      Top = 24
      Width = 545
      Height = 120
      ActiveCard = tsVendas
      BevelOuter = bvNone
      Caption = 'caFiltros'
      TabOrder = 1
      object tsVendas: TCard
        Left = 0
        Top = 0
        Width = 545
        Height = 120
        CardIndex = 0
        TabOrder = 0
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 91
          Height = 15
          Caption = 'Nome do cliente:'
          Color = clSilver
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object Label2: TLabel
          Left = 0
          Top = 48
          Width = 91
          Height = 15
          Caption = 'Modelo do carro:'
          Color = clSilver
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object edClientesVendas: TEdit
          Left = 0
          Top = 16
          Width = 545
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 0
        end
        object cbModelosVendas: TComboBox
          Left = 0
          Top = 64
          Width = 273
          Height = 23
          Style = csDropDownList
          TabOrder = 1
          TextHint = 'Selecione...'
          OnChange = cbModelosVendasChange
          Items.Strings = (
            'Modelos de carros'
            'Pessoas'
            'Hist'#243'rico de vendas')
        end
      end
      object tsCliente: TCard
        Left = 0
        Top = 0
        Width = 545
        Height = 120
        CardIndex = 1
        TabOrder = 1
        object Label3: TLabel
          Left = 0
          Top = 0
          Width = 91
          Height = 15
          Caption = 'Nome do cliente:'
          Color = clSilver
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object edClientes: TEdit
          Left = 0
          Top = 16
          Width = 545
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 0
        end
      end
      object tsCarros: TCard
        Left = 0
        Top = 0
        Width = 545
        Height = 120
        Caption = 'tsCarros'
        CardIndex = 2
        TabOrder = 2
        object lbModelos: TLabel
          Left = 0
          Top = 0
          Width = 91
          Height = 15
          Caption = 'Modelo do carro:'
          Color = clSilver
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object cbModelos: TComboBox
          Left = 0
          Top = 16
          Width = 273
          Height = 23
          BevelInner = bvLowered
          BevelOuter = bvNone
          Style = csDropDownList
          TabOrder = 0
          TextHint = 'Selecione...'
          OnChange = cbModelosChange
        end
      end
      object tsSorteio: TCard
        Left = 0
        Top = 0
        Width = 545
        Height = 120
        Caption = 'tsSorteio'
        CardIndex = 3
        TabOrder = 3
      end
    end
    object btLocalizar: TButton
      Left = 8
      Top = 88
      Width = 118
      Height = 23
      Caption = 'Localizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btLocalizarClick
    end
  end
  object paGrid: TPanel
    Left = 0
    Top = 209
    Width = 942
    Height = 423
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    object grDadosCadastrados: TDBGrid
      Left = 0
      Top = 0
      Width = 938
      Height = 419
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = grDadosCadastradosDrawColumnCell
      Columns = <
        item
          Expanded = False
          Title.Caption = 'Nome'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'CPF/CNPJ'
          Width = 142
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Modelo'
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Data do Lan'#231'amento'
          Width = 157
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Nome do cliente'
          Width = 154
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Modelo vendido'
          Width = 127
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Total vendido'
          Visible = True
        end>
    end
  end
  object paInferior: TPanel
    Left = 0
    Top = 632
    Width = 942
    Height = 85
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      942
      85)
    object lbClientesSemVenda: TLabel
      Left = 8
      Top = 43
      Width = 348
      Height = 19
      Anchors = [akLeft, akBottom]
      Caption = 'XX clientes cadastrados n'#227'o efetuaram nenhuma venda.'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btCadastrarClientes: TButton
      Left = 488
      Top = 39
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cadastrar clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btCadastrarClientesClick
    end
    object btCadastrarCarros: TButton
      Left = 605
      Top = 39
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cadastrar carros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btCadastrarCarrosClick
    end
    object btExcluirVendas: TButton
      Left = 834
      Top = 39
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Excluir vendas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btExcluirVendasClick
    end
    object btInserirVendas: TButton
      Left = 722
      Top = 39
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Inserir vendas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btInserirVendasClick
    end
  end
  object qrClientes: TFDQuery
    Connection = dmSistemaSorteio.FDConexao
    SQL.Strings = (
      '')
    Left = 736
    Top = 404
  end
  object qrVendas: TFDQuery
    Connection = dmSistemaSorteio.FDConexao
    SQL.Strings = (
      '')
    Left = 800
    Top = 404
  end
  object qrCarros: TFDQuery
    Connection = dmSistemaSorteio.FDConexao
    SQL.Strings = (
      '')
    Left = 856
    Top = 404
  end
  object dsGrid: TDataSource
    Left = 848
    Top = 345
  end
end
