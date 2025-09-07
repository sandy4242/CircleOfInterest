
# 🎉 CircleOfInterest — Event Planner App

CircleOfInterests is a cross-platform mobile app designed to help people **create, discover, and join community-driven events** based on shared interests.  
Whether it's a book club meetup, hobby workshop, study group, or any interest-based gathering — this app makes planning and participating in events effortless.

---

## 🚀 Project Idea

People often struggle to find events and meetups around their interests.  
CircleOfInterests makes it simple to:
- Create events  
- Browse events by category and location  
- Join events and RSVP  
- Communicate with organizers & attendees  
- Receive real-time notifications

---

## ✅ Tech Stack

| Purpose | Tech |
|---------|------|
| Frontend | Flutter (iOS & Android) |
| Backend | Supabase (Postgres, Auth, Realtime) |
| Notifications | Firebase Cloud Messaging |
| Maps | Google Maps API |
| State Management | BloC |

---

## 🎯 Features & Screens

### ✅ 1. Authentication
- Sign Up / Login (Email + Password, OAuth options)

---

### ✅ 2. Home Screen
- Discover upcoming events  
- Search & Filter by category, location, date  
- Event list with cards showing basic info

---

### ✅ 3. Event Details Screen
- Full event description  
- Date, Time, Location (with map preview)  
- Organizer contact  
- RSVP / Join Button  
- Attendee list (optional)  

---

### ✅ 4. Create Event Screen
- Title, Description, Date & Time  
- Location picker (Google Maps integration)  
- Category (Book Club, Workshop, etc.)  
- Privacy setting (Public / Private)

---

### ✅ 5. User Profile Screen
- View user info, past joined events  
- Edit Profile

---

### ✅ 6. Chat Screen
- Real-time chat between organizer and attendees  
- Group chat for events  

---

### ✅ 7. Notifications
- Push notifications for upcoming events  
- Event updates

---

## 🌐 Architecture Diagram

```

\[ Flutter Frontend ] ↔ \[ Supabase Backend (Postgres + Auth + Realtime) ]
↘
\[ Firebase Cloud Messaging ]

```

---

## 📋 Project Roadmap

### ✅ MVP (Minimum Viable Product)
- Authentication flow  
- Event creation & listing  
- Event detail view & RSVP  
- Basic user profile  
- Real-time chat using Supabase Realtime  

### ⚡ Next Steps
- Push notifications integration  
- Google Maps integration  
- Advanced filters (by distance, category)  
- Event rating & reviews  
- Polls & surveys  
- Payment integration (for paid events)

---

## 🤝 How to Contribute

We welcome contributors!  
Steps to contribute:
1. Fork the repo  
2. Clone it locally  
3. Setup Supabase project (https://supabase.io)  
4. Configure `.env` with your Supabase keys  
5. Create a new branch for your feature  
6. Make your changes → Commit → Push → Create Pull Request

👉 Join our community for support & collaboration:  
[Discord Channel](https://discord.gg/WZemvWQdJy)

---

## 📜 License

MIT License

---

## 💡 Contact

For questions or feature requests, join our Discord or create an issue.

---

🚀 Let’s build a community around shared passions! 🌟