namespace :db do
  task seed_leaders: :environment do
    ['Adrian Costa', 'Adrian Ferreyra', 'Alejandro Hermida', 'Alonso Alvarez', 'Alper Ergökmen ', 'Andres Molina', 'Andres Sautel', 'Brenno Marques'
, 'Bruno Tombari', 'Bulent Karabagli', 'Carlitos Espinoza ', 'Carlos Santos David', 'Chicho Frumboli', 'Christian Marquez', 'Daniel Arroyo', 'Daniel Nacucchio', '
Danilo Maddalena', 'Diego Riemer', 'Dmitriy Kuznetsov', 'Dmitry Vasin', 'Dominic Bridge', 'Emiliano Alcaraz', 'Eric Lindgren', 'Fabian Peralta', 'Facundo de la Cr
uz', 'Facundo Pinero', 'Fausto Carpino', 'Federico Naveira', 'Felix Naschke', 'Fernando Sanchez', 'Gaspar Godoy', 'Gaston Camejo', 'Germán Ballejo', 'Gianpiero Ga
ldi ', 'Giuseppe Vento', 'Guille Barrionuevo', 'Horacio Godoy', 'Horia Călin Pop', 'Hugo Patyn', 'Iris Basak Dogdu', 'Ismael Ludman ', 'Ivan Terrazas', 'Jakub Grz
ybek', 'Javier Rodriguez', 'Joachim Dietiker', 'Jonathan Saavedra', 'Jorge Lopez', 'Joscha Engel', 'José Luis González', 'Juan Malizia', 'Juan Martin', 'Juan Mart
in Carrara', 'Juan Pablo Ramirez', 'Julian Vilardo', 'Julio Balmaceda', 'Julio Cesar Calderon', 'Leandro Palou', 'Leonel Mendieta', 'Levan Gomelauri', 'Loukas Bal
okas', 'Lucas Carrizo', 'Lucas Molina Gazcon', 'Lucian Stan', 'Mariano Otero', 'Marko Miljevic', 'Martin Maldonado', 'Martin Ojeda', 'Matteo Panero', 'Maurizio Gh
ella', 'Max van de Voorde', 'Maxim Gerasimov', 'Maximiliano Cristiani', 'Michael Nadtochi', 'Miguel Angel Zotto', 'Murat Erdemsel', 'Neri Piliu', 'Nick Jones', 'N
icolás di Rago', 'Nito', 'Onur Gumrukcu', 'Özgür Arin', 'Pablo Alvarez', 'Pablo Inza', 'Pablo Rodriguez', 'Rafael Busch', 'Raúli Choque', 'René–Marie Meignan', 'R
oberto Zuccarino', 'Ruben Veliz', 'Sebastian Arce', 'Sebastian Archaval', 'Sebastian Jimenez', 'Sercan Yigit', 'Steinar Refsdal', 'Utku Kuley', 'Vaggelis Hatzopou
los', 'Walter “Chino” Laborde', 'Yannick Vanhove'].each do |leader_name|
      Leader.create(name: leader_name)
    end
  end
end
