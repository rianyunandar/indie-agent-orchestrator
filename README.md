# Enterprise-Grade Agentic Framework (Roo Code / DeepSeek)

## Based : https://github.com/affaan-m/everything-claude-code

Framework ini adalah sistem kerja agentik yang dibuat untuk kondisi dunia nyata: proyek banyak, waktu sempit, koneksi tidak selalu stabil, dan budget API harus dihitung per token. Arsitektur utamanya project-agnostic, modular, dan fault-tolerant agar bisa dipasang di berbagai repository tanpa mengunci ke stack tertentu.

## The Manifesto (Why This Exists)

Framework ini lahir bukan dari kemewahan, tapi dari kebutuhan yang tidak bisa ditunda.

Di banyak daerah, termasuk Lampung, seorang profesional IT bisa memegang beban infrastruktur lintas sistem sekaligus: layanan pendidikan, sistem operasional lapangan, sampai administrasi publik. Ekspektasi kerja tetap tinggi, tetapi standar rate sering jauh dari kota besar. Pilihan merantau demi kompensasi lebih tinggi bukan keputusan sederhana, karena risikonya finansial, mental, dan sosial.

Di saat pengeluaran bulanan bisa melampaui gaji tetap, strategi bertahan hidup seorang engineer berubah: bukan hanya bekerja lebih keras, tetapi bekerja lebih cerdas. Otomatisasi bukan gaya-gayaan, melainkan cara menjaga sistem tetap jalan sambil membuka ruang untuk sumber pendapatan lain. Dalam konteks ini, penggunaan model berbiaya efisien seperti DeepSeek dengan budget terbatas adalah keputusan arsitektural, bukan kompromi kualitas.

Karena itu framework ini didesain dengan dua naluri inti:

1. Hemat token dengan Dynamic Retrieval: agent hanya memuat konteks yang relevan ketika dibutuhkan.
2. Tahan timeout dengan Micro-Saving: progres kecil disimpan terus-menerus agar tidak hilang saat koneksi putus.

Tujuan akhirnya bukan sekadar “kode selesai”. Tujuan akhirnya adalah menjaga keberlanjutan kerja, kesehatan mental, dan kualitas hidup. Teknologi di sini berfungsi sebagai mesin waktu, supaya engineer tetap hadir secara utuh untuk keluarga.

## Core Features

### 1. Project-Agnostic + Auto-Discovery

- Tidak ada hardcode nama proyek, layanan, atau stack di instruksi inti.
- Saat sesi dimulai, agent wajib mendeteksi environment dari manifest dan struktur direktori.
- Cocok untuk repo apa pun: web app, backend service, automation tool, atau monorepo campuran.

### 2. Strict Modularity + Dynamic Retrieval

- Skill disimpan per file di folder `.ai/skills/`.
- Hook disimpan per file di folder `.ai/hooks/`.
- Agent wajib menjalankan `ls .ai/skills/` dan `cat .ai/skills/<skill>.md` sebelum eksekusi tugas.
- Ini menjaga konteks tetap ramping, cepat, dan murah token.

### 3. Anti-Timeout Micro-Saving

- Plan ditulis dalam checkbox di `.ai/scratchpad.md`.
- Setiap langkah kecil atau 1 file selesai wajib langsung ditandai `[x]`.
- Save point dibuat berkala agar sesi bisa dilanjutkan tanpa kehilangan progres.
- Sangat penting untuk model eksekutor yang rentan timeout koneksi.

### 4. Approval Gate by Design

- Untuk task non-trivial, agent wajib berhenti di fase plan.
- Eksekusi perubahan kode hanya boleh dimulai setelah user membalas: **Lanjut**.
- Ini menjaga kontrol tetap di tangan Tech Lead sekaligus menurunkan risiko perubahan liar.

## Installation & Usage

### 1. Pasang framework ke repository target

Salin file dan folder berikut ke root repository:

- `.clinerules`
- `.ai/RULES.md`
- `.ai/ARCHITECTURE.md`
- `.ai/scratchpad.md`
- `.ai/MEMORY.md`
- `.ai/SKILLS.md`
- `.ai/AGENTS.md`
- `.ai/skills/`
- `.ai/hooks/`

### 2. Jalankan session bootstrap

```bash
bash .ai/hooks/session-boot.sh
```

### 3. Lakukan dynamic skill loading

```bash
ls .ai/skills/
cat .ai/skills/<skill-name>.md
```

### 4. Tulis plan sebelum coding

Gunakan template checkbox di `.ai/scratchpad.md`, lalu tunggu persetujuan user.

Status yang benar sebelum eksekusi:

- `Status: AWAITING APPROVAL`
- User sudah membalas: `Lanjut`

### 5. Eksekusi bertahap dengan micro-saving

- Selesaikan langkah kecil
- Centang checkbox `[x]`
- Simpan save point
- Lanjut ke langkah berikutnya

### 6. Tutup task dengan quality gate

- Jalankan pre-commit hook
- Pastikan test/lint/type-check sesuai aturan
- Catat ringkasan ke `.ai/MEMORY.md`

## Quick Repository Map

- `.clinerules`: router aturan utama
- `.ai/RULES.md`: aturan operasional dan larangan mutlak
- `.ai/ARCHITECTURE.md`: template auto-discovery
- `.ai/scratchpad.md`: plan + micro-save tracker
- `.ai/MEMORY.md`: rolling window memory
- `.ai/skills/`: skill modular per file
- `.ai/hooks/`: skrip bash untuk bootstrap, pre-commit, post-task

## Epilogue

Framework ini ditulis untuk mereka yang tetap memilih bertahan, membangun, dan bertumbuh dari daerah, meski harus menghadapi keterbatasan yang sering tidak terlihat di permukaan.

Semoga setiap baris kerja yang dijalankan lewat framework ini menjadi jalan rezeki yang lapang, memudahkan kita menutup seluruh kebutuhan hidup dengan tenang, dan menguatkan langkah kita untuk terus berjuang membahagiakan keluarga tercinta.

Amin.

## Support
yang mau mendukung bantu bapak ini beli susu dan popok saya silahkan donasi ke 
https://trakteer.id/rianyunandar/tip



