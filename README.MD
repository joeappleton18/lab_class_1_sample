## COM1025: Web and Database Systems

## LAB 1

In this first Lab you will start by becoming familiar with the software that we will be using for the database and web development as well as the entity-relationship (data) modelling. You will be using the software installed for you in Azure Labs via the terminals in the IFH Lab. You can access Azure from a browser on your own computer as well. If you prefer, you can also install the software on your own laptops to use for the lab sessions and for independent learning.

The software we will be using is:

- [Laragon](https://laragon.org/). An open-source (free) web
  development tool that packages the MySQL Server, Apache Server and Node in one environment.
  Laragon is similar to Xampp (Linux) and Mamp (Macs).

- [Diagram.net](https://app.diagrams.net/). For the Data Modelling we will be using diagrams.net, a free web-based software that does not need login credentials and is easy to use

You will first check that the software is configured and working properly and then you will run some code from a student’s project in a previous year to get an idea of the end goal of the module. You should be aware that, last year, we are using PHP and this year we are using NODE. As such, we've recreated a this particular student's project in NODE.

## Laragon Software Set-Up Azure Labs

1. Log on to your terminal in the Lab with the university username and password.
2. Open your university outlook email account – you will find an email from IT Services with a
   link to register with Azure Labs. That link will require you to sign in using your university
   account and then you will see a page with the following ‘virtual machine’:
   COM1025: Web and Database Systems.

![](./assets/1.lab_pic.png)

To sign on to the virtual desktop that is running Laragon, you will need different credentials to your university login details. Click on the three dots and then the option ‘Reset password’.

![](assets/2.password_reset.png)

![](assets/3.password_dialogue.png)

Type in a password you want in the pop-up window and then click on the button ‘Reset
password’. This might take some time. Note that the username has already been set to
‘labuser’ – this cannot be changed.

3. Once the password has been set, toggle the virtual machine from ‘Stopped’ to ‘Running’. This may also take a few moments the first time. When it has changed the status to ‘Running’, then elect the small monitor icon at the bottom which will download a connection file with a .rdp extension.

![](assets/4.running_vm.png)

![](assets/5.png)

1. Next click on the .rdp file, which will run the file. If you see the following pop-up window just  click cancel on this message. You should see a window as shown below where you will be asked to enter a password. The username has been set to labuser by default – you need to remove the ~\. Add the new password you created previously.

![](./assets/6.password.png)

5. You should see a window as shown below where you will be asked to enter a password. The
   username has been set to labuser by default – **you need to remove the ~\.** Add the new
   password you created previously.

![](assets/7.rdp_auth.png)

6. Press OK to continue. The virtual desktop will display as below. If the desktop does not fit the  screen you will need to click on the button highlighted in red to scale the desktop correctly. If you are prompted to sync your OneDrive then you can do so by entering your university username and password. Do NOT click on the cro``ss in the red circle

![](assets/8.Laragon_desktop.png)

7. You should, now, be able to open Laragon by clicking the desktop icon. To start MySQL press the "Start ALL" button. You should see the Apache daemon and the MySQL server being started. The 80 and the 3306 are their port numbers, respectively.

![](assets/9.running_demon.png)

### Using MySQL

1. Now let us try out the MySQL Server. On the main menu of Laragon click on the button that
says Terminal. A command line terminal window will pop up. The prompt will be showing
`C:\laragon\www`. We need to navigate to the folder from where we can start MySQL.

2. Type in `cd ..` after the prompt and press ENTER (this will take you one level up to the Laragon directory) TIP: You can use the command `ls`` to list the folders and files in a directory.

3. Then type in or copy-paste the path to the MySQL bin directory from where we can
run the server: `cd bin\mysql\mysql-8.0.30-winx64\bin`

4. Now type in the command to get MySQL started: `mysql -u root -p` and press ENTER. It will prompt you for a password. Just press ENTER again because a password has not been specified. The username is root. You should get a welcome message from the MySQL monitor. Type in the following command at the mysql> prompt: `SHOW databases;` (don’t forget the semi-colon) and you will get a table with all the current databases listed as shown in the screenshot below.

![](assets/10.databases.png)

>> This shows that your software is working fine. If you want to close the Terminal then
type in exit to shut down the MySQL monitor first. You will be using it again later so
better to keep it open.

**IMPORTANT – Click on the Stop button on the Laragon menu if you want to close it. This will
shut down the servers properly and prevent you having any problems with them.**


### Running the Code of a Library System (student project)

In this part you are going to run the code from a student’s sample project from a previous year. Recall from earlier, this project has been migrated from PHP to Node.  This will give you an idea of what you will be expected to produce at the end of the semester. You are not expected to understand the code yet, just to make the code work and get an idea of what the code is doing. In this section you will also get experience with using the GUI that comes with Laragon called HeidiSQL.

1. Download the Library.zip folder you will see under Lab 1 on SurreyLearn. Extract it and you will see it contains a number of files - right-click on the folder and select extract all:

   - README.MD
   - package.json
   - package-lock.json
   - views/loan.ejs
   - assets/


1. Open the Laragon terminal
	- `mkdir C:\code`
	- `cd C:\code`
	- `git clone https://github.com/joeappleton18/lab_class_1_sample.git`
	- `cd lab_class_1_sample`
	- `npm install`
	- `npm run start`

  