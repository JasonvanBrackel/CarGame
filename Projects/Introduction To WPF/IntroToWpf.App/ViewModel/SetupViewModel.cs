using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Objects;
using System.Linq;
using System.Text;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using IntroToWpf.App.Commands;
using IntroToWpf.Data;
using Type = IntroToWpf.Data.Type;

namespace IntroToWpf.App.ViewModel
{
    class SetupViewModel : INotifyPropertyChanged
    {
        private Entities _entities;
        private SetupWindow _window;

        public SetupViewModel() : this(new Entities())
        {
            
        }

        private SetupViewModel(Entities entities)
        {
            _entities = entities;
            MoveBack = new RelayCommand<int>(LoadPreviousVehicle);
            MoveForward = new RelayCommand<int>(LoadNextVehicle);
            Save = new RelayCommand<int>(SaveVechicle);
            Close = new RelayCommand<int>((i) => _window.Close());
            Types = _entities.Types.ToList();
            _window = new SetupWindow();
            _window.DataContext = this;
            Load(_entities.Vehicles);
            _window.ShowDialog();
        }

        private void Load(ObjectSet<Vehicle> vehicles)
        {
            UpdateUi(vehicles.First());
        }

        private void LoadPreviousVehicle(int currentVehicleId)
        {
            Load(_entities.GetPreviousVehicle(currentVehicleId));
        }

        private void Load(ObjectResult<Vehicle> vehicles)
        {
            var vehicle = vehicles.First();
            UpdateUi(vehicle);
        }

        private void UpdateUi(Vehicle vehicle)
        {
            Id = vehicle.Id;
            Name = vehicle.Name;
            Type = vehicle.TypeId;
            ImagePath = vehicle.ImagePath;
            Image = new BitmapImage(new Uri(ImagePath, UriKind.Relative));
            RaisePropertyChanged("Id");
            RaisePropertyChanged("Name");
            RaisePropertyChanged("Type");
            RaisePropertyChanged("ImagePath");
            RaisePropertyChanged("Image");
            RaisePropertyChanged("Types");
        }

        private void LoadNextVehicle(int currentVehicleId)
        {
            Load(_entities.GetNextVehicle(currentVehicleId));
        }

        private void SaveVechicle(int currentVehicleId)
        {
            var vehicle = _entities.Vehicles.Where(v => v.Id.Equals(currentVehicleId)).Single();
            vehicle.Name = Name;
            vehicle.TypeId = Type;
            vehicle.ImagePath = ImagePath;
            _entities.SaveChanges();
        }

        private void RaisePropertyChanged(string name)
        {
            if(PropertyChanged != null)
                PropertyChanged.Invoke(this, new PropertyChangedEventArgs(name));
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int Type { get; set; }
        public IList<Type> Types { get; private set; }
        public string ImagePath { get; set; }
        public BitmapImage Image { get; set; }
        public ICommand MoveBack { get; private set; }
        public ICommand MoveForward { get; private set; }
        public ICommand Save { get; private set; }
        public ICommand Close { get; private set; }
        public event PropertyChangedEventHandler PropertyChanged;
    }
}
