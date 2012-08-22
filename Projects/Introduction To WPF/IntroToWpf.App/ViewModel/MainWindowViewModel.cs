using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows.Controls.Primitives;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using IntroToWpf.App.Commands;
using IntroToWpf.Data;
using Type = IntroToWpf.Data.Type;

namespace IntroToWpf.App.ViewModel
{
    public class MainWindowViewModel : INotifyPropertyChanged
    {
        private Entities _entities;
        private MainWindow _window;
        private List<Type> _types;

        public MainWindowViewModel() : this(new Entities())
        {

        }

        private MainWindowViewModel(Entities entities)
        {
            _entities = entities;
            OpenSetup = new RelayCommand<string>((i) => new SetupViewModel());
            PickVehicleType = new RelayCommand<ButtonBase>(ButtonPushed);
            ShowNextVehicle = new RelayCommand<int>(MoveNext);
            _types = _entities.Types.ToList();
            _window = new MainWindow();
            _window.DataContext = this;
            _window.Show();
            Load(_entities.Vehicles.First());
        }

        private void Load(Vehicle vehicle)
        {
            Id = vehicle.Id;
            Image = new BitmapImage(new Uri(vehicle.ImagePath, UriKind.Relative));
            Name = vehicle.Name;
            Type = vehicle.TypeId;
            Smiley = "";
            RaisePropertyChanged("Id");
            RaisePropertyChanged("Image");
            RaisePropertyChanged("Name");
            RaisePropertyChanged("Type");
            RaisePropertyChanged("Smiley");
        }

        public BitmapImage Image { get; private set; }

        private void ButtonPushed(ButtonBase button)
        {
            DisableButtons();
            var selectedType = _types.Where(t => t.Name.Equals(button.Content)).Single();
            if (selectedType.Id == Type)
                Smiley = "Happy";
            else
                Smiley = "Sad";
            
            RaisePropertyChanged("Smiley");
        }

        public string Smiley { get; set; }

        private void MoveNext(int id)
        {
            Load(_entities.GetNextVehicle(id).First());
            EnableButtons();
        }

        private void EnableButtons()
        {
            _window.Car.Dispatcher.Invoke(new Action(() => _window.Car.IsEnabled = true));
            _window.Truck.Dispatcher.Invoke(new Action(() => _window.Truck.IsEnabled = true));
            _window.Motocycle.Dispatcher.Invoke(new Action(() => _window.Motocycle.IsEnabled = true));

        }

        private void DisableButtons()
        {
            _window.Car.IsEnabled = false;
            _window.Truck.IsEnabled = false;
            _window.Motocycle.IsEnabled = false;
        }

        private void RaisePropertyChanged(string name)
        {
            if (PropertyChanged != null)
                PropertyChanged.Invoke(this, new PropertyChangedEventArgs(name));
        }


        public ICommand OpenSetup { get; private set; }
        public ICommand PickVehicleType { get; private set; }
        public ICommand ShowNextVehicle { get; private set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public int Type { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;
    }
}