<h1><a name="readme-top"></a></h1>

[![Check http Stack](https://github.com/marcossilvestrini/learning-lpic-2-202-450/actions/workflows/check-bind-stack.yml/badge.svg)](https://github.com/marcossilvestrini/learning-lpic-2-202-450/actions/workflows/check-bind-stack.yml) [![Check http Stack](https://github.com/marcossilvestrini/learning-lpic-2-202-450/actions/workflows/check-http-stack.yml/badge.svg)](https://github.com/marcossilvestrini/learning-lpic-2-202-450/actions/workflows/check-http-stack.yml) [![PSScriptAnalyzer](https://github.com/marcossilvestrini/learning-lpic-2-202-450/actions/workflows/powershell.yml/badge.svg)](https://github.com/marcossilvestrini/learning-lpic-2-202-450/actions/workflows/powershell.yml)
# HTTP

![202-450 Linux Engineer](../../Images/web-servers.jpg)

<p align="center">
<strong>Explore the docs »</strong></a>
    <br />
    <a href="https://github.com/marcossilvestrini/learning-lpic-2-202-450">Main Page</a>
    -
    <a href="https://github.com/marcossilvestrini/learning-lpic-2-202-450/issues">Report Bug</a>
    -
    <a href="https://github.com/marcossilvestrini/learning-lpic-2-202-450/issues">Request Feature</a>
</p>

## Sumary

<details>
  <summary><b>TABLE OF CONTENT</b></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#instalation">Instalation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#freedoms">Four Essential Freedoms</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details><br>

<a name="about-the-project"></a>

## About Project

This project up a stack of HTTP server for labs.

## Whats is?

I this project, I up a stack of HTTP server with apache and nginx.


### Vagrant

 I use vagrant for provision all http server in this project.

### Shell provisioner

I use vagrant shell provisioner for configure http service and others tools
of this stack

### Git Actions (pipelines)

I use git actions for create a pipeline for my test in http stack

### Slack API

I use slack api and git actions for send a test that I execute after all
push\pull in this repository

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="getting-started"></a>

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

<a name="prerequisites"></a>

### Prerequisites

This is an example of how to list things you need to use the software
and how to install them.

* git
* Virtual Box and extencion
* Vagrant

<a name="instalation"></a>

### Installation

Clone the repo

```sh
git clone https://github.com/marcossilvestrini/learning-lpic-2-202-450.git
```

<a name="usage"></a>

## Usage

```sh
cd Vagrant/HTTP
vagrant up
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="roadmap"></a>

## Roadmap

* [x] Create IaC for provision Virtual Machines of Stack(Vagrant)
  * [x] Create vm ol9-apache-ha
  * [x] Create vm ol9-nginx-ha
  * [x] Create vm debian-apache-node01
  * [x] Create vm debian-apache-node02
* [x] Install and Configure Apache
  * [x] Create script for install and configure apache in server ol9-apache-ha
  * [x] Create script for install and configure apache in server debian-apache-node01
  * [x] Create script for install and configure apache in server debian-apache-node02
  * [x] Configure Https for all sites
  * [x] Configure Virtual host for all sites
  * [x] Configure authentication and authorization modules for sites(.htaccess,.htpasswd)
* [x] Create Script for Generate Certificates
  * [x] Generate a CA Root certificate
  * [x] Generate a Self-Signed Server certificate  
  * [x] Generate a Self-Signed Client certificate
* [x] Create script for Install and Configure Squid Proxy
  * [x] Install squid
  * [x] Configure Squid
* [x] Install and Configure Nginx
  * [x] Create script for install and configure apache in server ol9-nginx-ha
  * [x] Configure Reverse Proxy(loadbalance)
* [x] Create script for test Apache Stack
  * [x] Check Service is Running
  * [x] Check Version
  * [x] Check Status HTTP
  * [x] Check Status Module PHP
  * [x] Check Status Module Perl
* [x] Create pipeline for print test
* [x] Create pipeline for send test in slack channel

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributing

Contributions are what make the open source community such an amazing place to
learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and
create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

* This project is licensed under the MIT License * see the LICENSE.md file for details

## Contact

Marcos Silvestrini - marcos.silvestrini@gmail.com \
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/mrsilvestrini.svg?style=social&label=Follow%20%40mrsilvestrini)](https://twitter.com/mrsilvestrini)

Project Link: [https://github.com/marcossilvestrini/learning-lpic-2-202-450](https://github.com/marcossilvestrini/learning-lpic-2-202-450)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgments

* [http](https://www.isc.org/http/)
* [http Logging](https://www.zytrax.com/books/dns/ch7/logging.html)
* [Apache](https://www.apache.org/)
* [Nginx](https://www.nginx.com/)
* [Openssh](https://www.openssh.com/)
* [Squid](http://www.squid-cache.org/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[contributors-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[forks-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/network/members
[stars-shield]: https://img.shields.io/github/stars/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[stars-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/stargazers
[issues-shield]: https://img.shields.io/github/issues/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[issues-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/issues
[license-shield]: https://img.shields.io/github/license/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[license-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/marcossilvestrini
