import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/widgets/my_scrolling_container.dart';
import 'package:sw32_mad_project/styles/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeID = 'Privacy Screen';
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScrollingContainer(
      title: 'Privacy Policy',
      child: Text(
        privacyPolicyContent,
        style: kPrivacyPolicyTextStyle,
      ),
    );
  }
}

String privacyPolicyContent = '''

Dear Customer,

We make every effort to ensure the security and confidentiality of your data. We care about your privacy, both when you visit our Website, register an account with us and use our services, as well as when you contact us by phone, email or online chat, subscribe to our newsletter or visit our social media channels. We act in compliance with the rule of law, including provisions of the Regulation (EU) 2016/679 of the European Parliament and of the Council of 27 April 2016 on the protection of natural persons with regard to the processing of personal data and the free movement of such data and repealing Directive 95/46/EC (hereinafter the "GDPR").
In this document, we would like to provide you with essential information about your personal data processing. For the sake of clarity, we have put them together in the form of questions and answers. All of this is to let you know why, on what basis and for how long we process your data, as well as who can access it and what rights you have.

HOW DO WE ACCESS YOUR PERSONAL DATA?
Using the website [] (hereinafter: "Website"), you may be asked to provide your personal data. The provision of data is voluntary, but in certain situations, it may be necessary. For instance, if you do not provide us with your email address, we will not send you our newsletter, register your account or answer by email your question asked through the contact form.

 

Some data is collected automatically through cookies during your visit to the Website (e.g. IP address, browser type, operating system type, etc.). They are used to administer the Website, provide hosting services and create relevant marketing content. However, you can freely block and restrict the installation of cookies using your browser settings or the other (free) solutions.

 

who is the controller of your personal data?

 

The administrator of your personal data is Maciej Brzeziński Solutions with registered office Nowodwór 42, 08-503 Nowodwór, NIP (tax id): 7123421010, REGON: 389307464

 

If you have any questions or concerns, you can contact us electronically at the following email address: maciej.brzezinski@cooltodoapp.com

 

for what purpose, on what legal basis and for how long do we process your data?

 

We process your personal data:

to conclude and perform the contract for the provision of services (registration and maintenance of the Customer account, placing orders for free of charge and chargeable services, execution of the contract):

legal basis: the processing is necessary for the performance of the contract or in order to take steps at the request of the data subject before entering into a contract (Article 6(1)(b) of the GDPR),

the data will be processed until the end of performing the service (deletion of the Customer account, termination of the contract for the provision of services);

to comply with tax obligations (issuing invoices, keeping accounting records):

legal basis: the processing is necessary for compliance with a legal obligation to which we are subject (Article 6(1)(c) of the GDPR),

data will be processed until the expiry of the prescription periods for tax obligations;

to comply with personal data protection legal requirements:

legal basis: legal obligation incumbent upon us (Article 6(1)(c) of the GDPR),

data will be processed until the expiry of the prescription periods for claims due to the breach of data protection legislation;

to determine, pursue and defend possible claims:

legal basis: the processing is necessary for the purposes of our legitimate interests in taking actions aimed at protecting our rights in proceedings before the courts and other state authorities (Article 6(1)(f) of the GDPR),

the data will be processed until the expiry of the prescription periods for claims under applicable law;

to ensure the proper functioning of the Website and to analyse the activity of Website users:

legal basis: the processing is necessary for the purposes of our legitimate interests in conducting analyses and statistics on the use of particular functionalities of the Website (e.g. Google Analytics cookies, Facebook Pixel) (Article 6(1)(f) of the GDPR),

data will be processed until an effective objection is raised or the purpose of the processing is achieved;

to run a fan page on Facebook and to interact with the users of the aforementioned social media:

legal basis: the processing is necessary for the purposes of our legitimate interests in promoting the Website and adapt its functionalities to current needs (Article 6(1)(f) of the GDPR),

the data will be processed until the expiry of the prescription periods for claims under the applicable legislation;

to answer your questions addressed to us by telephone or email, including via the form available on the Website and online chat:

legal basis: the processing is necessary for the purposes of our legitimate interests in communicating with our Customers and answering questions from our potential customers or other persons interested in our products and services (Article 6(1)(f) of the GDPR),

the data will be processed until the expiry of the prescription periods for claims under applicable law;

for marketing purposes (promotion of our goods and services):

legal basis: the processing is necessary for the purposes of our legitimate interests in maintaining business relationships with Customers and surveying their satisfaction, looking after our own interests and image (Article 6(1)(a) of the GDPR), or respectively the processing is based under the voluntary consent of the person who has given it for a specific purpose (Article 6(1)(a) of the GDPR),

the data will be processed until an effective objection is raised or the purpose of the processing is achieved, and in the case where the basis for the processing is the consent of the data subject until the consent is withdrawn (whereby withdrawal of the consent does not affect the lawfulness of data processing prior to its withdrawal);

 

REMEMBER!

We process your personal data, as long as it is necessary to achieve the aforementioned purposes unless you make a valid and proper request for your personal data to be deleted. In addition, the period of the processing may be subject to the content of the legal provisions applicable to us, e.g. in the case of the storage of financial documents or the time limits for pursuing the claims.

 

who may be a recIpient of your personal data?

 

In certain situations, if this proves necessary for the purposes of data processing, we rely on the support and assistance of external entities. However, each time, prior to the transfer of personal data, we require the recipients to guarantee an adequate level of data protection and confidentiality.

 

The recipients of your personal data may be:

1)entities involved in the performance of our contracts, e.g., accounting office, IT services providers, hosting services providers, payment systems providers,

2)entities whose help and services we use in the scope of our business activity on the basis of separate agreements, e.g. providers of tools to analyse activity on the Website and direct marketing, suppliers of tools for creating landing pages and collecting leads, suppliers of the office systems, suppliers of project management software, suppliers of communication software,

3)authorised state authorities under applicable laws,

4)other entities whose request for data transfer is justified under the applicable laws.

 

DO WE TRANSFER PERSONAL DATA TO THIRD COUNTRIES?

 

In general, we do not transfer personal data to countries outside the European Union and the European Economic Area (EEA). However, if such a need arises in connection with the provision of services, we will assess the circumstances and ensure that an appropriate level of data protection is in place so that the processing is carried out in accordance with applicable legal regulations.

 

Operating the Website, we use services and technologies offered by the entities such as Facebook, Microsoft, Google, which are based in the United States and may partially process personal data using servers located outside the European Economic Area (EEA). In the light of the provisions of the GDPR, these are so-called entities located in third countries, in respect of which an assurance of an adequate level of protection or a note of the existence of appropriate safeguards must be demonstrated.

 

We ensure that the aforementioned entities apply the compliance mechanisms provided for by the GDPR (e.g. certificates) or standard contractual clauses adopted by the European Commission (Article 46(2)(c) of the GDPR). For more information on the data processing by the aforementioned entities, please visit the websites of the providers of these services.

 

do we profile your personal data?

 

As part of the Website and the technologies used, we may profile your data. This involves using your data (i.e. gender, age, interests, approximate location, your behaviour on the Website) to assess your activity and potential interest in the services.

 

The profiling makes it possible to personalise offer and advertisements addressed to the users; however it does not influence the terms and conditions of concluded contracts for the provision of the services. The information processed is anonymous and is not associated with the user ordering the services. Thus, we do not make any automated decisions that could have legal consequences for individuals or could affect them in a similarly significant manner.

 

WHAT PERSONAL DATA DO WE PROCESS AS A PROCESSOR AND HOW DO WE OBTAIN them?

 

Under the terms of service and any other separate agreements, we also act as a processor, processing personal data: email address. These data are collected and subsequently recorded in the Firebase system directly by the controller of these data, that is Google.

 

As a processor, we process data only on the documented instructions of the controller of such data (under a data entrustment agreement), committing ourselves to secure the data properly by applying appropriate technical and organisational measures and ensure an adequate level of protection corresponding to the risks involved in the processing of personal data (in accordance with the Article 32 of the GDPR). We also ensure that persons authorised by us to the process have undertaken to keep it confidential. Upon completion of the services relating to the processing of personal data entrusted to us, we will return all such data to the controller of such data (the Customer) and delete existing copies unless applicable law obliges us to store personal data.

 

do we use cookies?

 

On the Website we use so-called cookies ("cookies"), which are short text information stored on your computer, phone, tablet or other devices, which can be read by our system and also by the systems belonging to other entities whose services we use: Facebook, Google.

 

Thanks to cookies, we collect anonymous data about users' visits to the Website, which we can use to improve the functionality of the Website, identify errors or for marketing purposes.

 

Usually, web browsers allow the use of the cookies on the end device by default. However, users can block and restrict the installation of cookies at their own discretion, using their browser settings or by using other (free) solutions. During your first visit to the Website, we will display you the information on the use of cookies. If you do not change the settings of your browser, you will agree to their use. You can find more information on how to change your cookie settings on the website of your browser.

 

Please be informed that disabling or restricting the use of cookies may cause difficulties in using the Website, e.g. it may take longer to load the Website or restrict the use of its functionality or Facebook page likes.

 

how do we protect your data?

 

To ensure a high and consistent level of protection, we use IT environment safeguards adequate for the processing, as well as technical and organisational measures, which include, among others:

1)TLS protocol encryption,

2)creating backup copies,

3)equipping data centres with data protection mechanisms,

4)conducting regular security level tests,

5)monitoring the security of personal data,

6)mitigating the risk of potential abuses and reacting promptly in case of their occurrence,

7)implementing data protection policies,

8)ensuring continuous confidentiality, integrity, availability and resistance of the processing systems and services,

9)allowing access to personal data only to authorised persons,

10)creating and regularly modifying passwords to access systems where personal data are processed.

 

WHAT RIGHTS DO DATA SUBJECTS HAVE?

 

Data subjects whose data we process have the rights to:

1)access to their personal data;

2)change their personal data;

3)remove their personal data;

4)restrict the processing of personal data;

5)object to the processing of personal data;

6)transfer the personal data;

7)withdraw consent to the processing of personal data (provided that the processing is based on the consent of a data subject).

 

However, the rights listed above are not absolute, and in certain circumstances, after analysis, we may legitimately refuse to exercise them.

 

Please also be informed that the withdrawal of your consent to data processing will not affect the lawfulness of data processing that took place on the basis of the consent given before its withdrawal.

 

If you request us to exercise any of the above rights, we will respond to your request without delay, but no later than within one month of its receipt. If due to the complexity of the request or the number of requests, we are unable to comply with your request within one month, we will comply with it within a further two months. However, we will inform you of the intended extension of the deadline beforehand.

 

HOW CAN YOU COMPLAINT ABOUT IRREGULARITIES IN THE PROCESSING OF PERSONAL DATA?

 

If you believe that your personal data is processed by us contrary to the applicable law, you can file a complaint with the President of the Office for Personal Data Protection.

 

Does using the Website involve sending logs to the server?

 

The use of the Website involves sending queries to the server on which the Website is hosted. Each query sent to the server is recorded in server logs and stored on the server. The logs include, among others, the IP address, date and time of the server, information about the Internet browser and operating system.

 

The data stored in the server logs are not associated with specific users of the Website and are not used by us to identify you.

 

The server logs constitute solely auxiliary material used to administer the Website, and their content is not disclosed to anyone except persons authorised to administer the server.

 

 

CAN WE AMEND OUR PRIVACY POLICY?

Yes. Personal data protection is a process that we adapt to meet current needs and changing technology. Therefore, our Privacy Policy may be supplemented or amended, as we will inform you by a post on the Website, and in the event of material changes, we will send separate notices on the amendment to registered service users by email.
''';
